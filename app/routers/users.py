import asyncpg
from typing import Optional
from app.database import get_db
from fastapi import APIRouter, Depends, HTTPException
from app.core.deps import get_current_user
from app.core.auth import hash_password
from app.schemas import (
    UpdateProfileRequest, UpdateProfileResponse,
    UserResponse, DeleteAccountRequest
)

router = APIRouter(prefix="/users", tags=["users"])

@router.put("/profile", response_model=UpdateProfileResponse)
async def update_user_profile(
    request: UpdateProfileRequest,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    """
    Update user profile (username, photo_url, or password)
    """
    try:
        # Hash password if provided
        hashed_password = hash_password(request.password) if request.password else None
        
        await db.execute(
            "CALL update_user_profile($1, $2, $3, $4)",
            current_user.user_id, request.username, request.photo_url, hashed_password
        )
        
        # Get updated user info
        updated_user = await db.fetchrow(
            "SELECT * FROM get_user_by_email($1)", current_user.email
        )
        
        return UpdateProfileResponse(
            success=True,
            message="Profile updated successfully",
            username=updated_user["username"],
            photo_url=updated_user["photo_url"]
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.delete("/profile", response_model=UpdateProfileResponse)
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
        # Hash the provided password
        hashed_input = hash_password(request.password)
        
        # Call procedure that verifies and deletes
        await db.execute(
            "CALL remove_user_with_verification($1, $2)",
            current_user.user_id, hashed_input
        )
        
        return UpdateProfileResponse(
            success=True,
            message="User account deleted successfully"
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
