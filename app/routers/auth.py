from fastapi import APIRouter, Depends, HTTPException
import asyncpg
from app.database import get_db
from app.schemas import UserLogin, UserRegister, TokenResponse
from app.core.auth import hash_password, verify_password, create_access_token

router = APIRouter(prefix="/auth", tags=["Authentication"])

@router.post("/register", response_model=TokenResponse)
async def register(
    user: UserRegister,
    db: asyncpg.Connection = Depends(get_db)
):
    # 1. Check if user already exists
    existing = await db.fetchrow(
        "SELECT user_id FROM users WHERE email = $1", user.email
    )
    if existing:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    # 2. Hash the password
    hashed = hash_password(user.password)
    
    # 3. Call stored procedure to insert user
    await db.execute(
        "CALL register_user($1, $2, $3, NULL)",
        user.username, user.email, hashed
    )
    
    # 4. Get the created user using existing function
    result = await db.fetchrow(
        "SELECT * FROM get_user_by_email($1)", user.email
    )
    
    # 5. Create JWT token
    token = create_access_token(data={"sub": str(result["user_id"]), "email": result["email"]})
    
    # 6. Return response
    return TokenResponse(
        access_token=token,
        token_type="bearer",
        user_id=result["user_id"],
        username=result["username"],
        email=result["email"]
    )


@router.post("/login", response_model=TokenResponse)
async def login(
    user: UserLogin,
    db: asyncpg.Connection = Depends(get_db)
):
    # Get user from database using existing function
    db_user = await db.fetchrow(
        "SELECT * FROM get_user_by_email($1)", user.email
    )
    
    if not db_user:
        raise HTTPException(status_code=401, detail="Invalid email or password")
    
    if not verify_password(user.password, db_user["password_hash"]):
        raise HTTPException(status_code=401, detail="Invalid email or password")
    
    token = create_access_token(data={"sub": str(db_user["user_id"]), "email": db_user["email"]})
    
    return TokenResponse(
        access_token=token,
        token_type="bearer",
        user_id=db_user["user_id"],
        username=db_user["username"],
        email=db_user["email"]
    )