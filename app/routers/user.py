from fastapi import APIRouter, Depends, HTTPException
import asyncpg
from typing import Optional
from app.database import get_db
from app.core.deps import get_current_user
from app.schemas import (
    ProfileHeaderResponse,
    UserResponse, WatchlistItemResponse,
    UserRatingResponse
)

router = APIRouter(prefix="/user", tags=["User"])


@router.get("/profile", response_model=ProfileHeaderResponse)
async def get_profile_header(
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    row = await db.fetchrow(
        "SELECT * FROM get_profile_header($1)", 
        current_user.user_id
    )
    
    if not row:
        raise HTTPException(status_code=404, detail="User profile not found")
    
    return ProfileHeaderResponse(**dict(row))


@router.get("/watchlist", response_model=list[WatchlistItemResponse])
async def get_user_watchlist(
    status: Optional[str] = None,
    limit: int = 10,
    offset: int = 0,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_user_watchlist($1, $2, $3, $4)", 
        current_user.user_id, status, limit, offset
    )
    
    if not rows:
        raise HTTPException(status_code=404, detail="No watchlist items found")
    
    return [WatchlistItemResponse(**dict(row)) for row in rows]


@router.get("/ratings", response_model=list[UserRatingResponse])
async def get_user_ratings(
    limit: int = 5,
    offset: int = 0,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_user_ratings($1, $2, $3)", 
        current_user.user_id, limit, offset
    )
    
    if not rows:
        raise HTTPException(status_code=404, detail="No ratings found for this user")
    
    return [UserRatingResponse(**dict(row)) for row in rows]