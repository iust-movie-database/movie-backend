import asyncpg
from typing import Optional
from app.database import get_db
from fastapi import APIRouter, Depends, HTTPException
from app.core.deps import get_current_user
from app.core.auth import hash_password, verify_password, create_access_token
from app.schemas import (
    UpdateProfileRequest, UpdateProfileResponse,
    UserResponse, DeleteAccountRequest, TokenResponse
)

router = APIRouter(prefix="/profile", tags=["profile"])

@router.put("/", response_model=TokenResponse)
async def update_user_profile(
    request: UpdateProfileRequest,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    try:
        # Get user from database using existing function
        user = await db.fetchrow(
            "SELECT * FROM get_user_by_email($1)", current_user.email
        )
        if not user:
            raise HTTPException(status_code=401, detail="user not found")
        
        user_password_hash = user["password_hash"]
        if not verify_password(request.current_password, user_password_hash):
            raise HTTPException(status_code=401, detail="Invalid email or password")

        # Hash new password if provided
        hashed_new = hash_password(request.new_password) if request.new_password else None
        await db.execute(
            "CALL update_user_profile($1, $2, $3, $4, $5)",
            current_user.user_id,
            request.username,
            request.email,
            request.photo_url,
            hashed_new
        )
        
        # Get updated user info
        updated_user = await db.fetchrow(
            "SELECT * FROM get_user_by_email($1)", 
            request.email if request.email else current_user.email
        )
        
        new_token = create_access_token(
            data={"sub": str(updated_user["user_id"]), "email": updated_user["email"]}
        )
        
        return TokenResponse(
            access_token=new_token,
            token_type="bearer",
            user_id=updated_user["user_id"],
            username=updated_user["username"],
            email=updated_user["email"]
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.delete("/", response_model=UpdateProfileResponse)
async def delete_user_profile(
    request: DeleteAccountRequest,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    """
    Delete user account permanently.
    Requires password confirmation.
    """
    try:
        # Get user from database using existing function
        user = await db.fetchrow(
            "SELECT * FROM get_user_by_email($1)", current_user.email
        )
        if not user:
            raise HTTPException(status_code=401, detail="user not found")
        
        user_password_hash = user["password_hash"]
        if not verify_password(request.password, user_password_hash):
            raise HTTPException(status_code=401, detail="Invalid email or password")
        # Call procedure that verifies and deletes
        await db.execute(
            "CALL remove_user($1)",
            current_user.user_id
        )
        
        return UpdateProfileResponse(
            success=True,
            message="User account deleted successfully"
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
