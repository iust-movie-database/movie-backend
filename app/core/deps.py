from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from app.core.auth import decode_access_token
from app.database import get_db
from app.schemas import UserResponse
import asyncpg
from typing import Optional

security = HTTPBearer(auto_error=False) 

async def get_current_user(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security),
    db: asyncpg.Connection = Depends(get_db)
) -> UserResponse:
    """
    REQUIRED authentication.
    Returns validated UserResponse object using your database function.
    """
    if not credentials:
        raise HTTPException(status_code=401, detail="Not authenticated")
    
    token = credentials.credentials
    payload = decode_access_token(token)
    
    if not payload:
        raise HTTPException(status_code=401, detail="Invalid or expired token")
    
    email = payload.get("email")
    if not email:
        raise HTTPException(status_code=401, detail="Invalid token")
    
    user = await db.fetchrow(
        "SELECT * FROM get_user_by_email($1)", email
    )
    
    if not user:
        raise HTTPException(status_code=401, detail="User not found")
    
    return UserResponse(**dict(user))


async def get_current_user_optional(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security),
    db: asyncpg.Connection = Depends(get_db)
) -> Optional[UserResponse]:
    """
    OPTIONAL authentication.
    Returns UserResponse if token valid, None otherwise.
    """
    if not credentials:
        return None
    
    token = credentials.credentials
    payload = decode_access_token(token)
    
    if not payload:
        return None
    
    email = payload.get("email")
    if not email:
        return None
    
    user = await db.fetchrow(
        "SELECT * FROM get_user_by_email($1)", email
    )
    
    return UserResponse(**dict(user)) if user else None