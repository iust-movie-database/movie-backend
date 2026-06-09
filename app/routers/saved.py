from fastapi import APIRouter, Depends, HTTPException
import asyncpg
from app.database import get_db
from app.schemas import SaveTitleRequest, SaveTitleResponse, UserResponse
from app.core.deps import get_current_user

router = APIRouter(prefix="/saved", tags=["Saved"])

@router.post("/{title_id}", response_model=SaveTitleResponse)
async def save_title(
    title_id: int,
    request: SaveTitleRequest,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    """
    Save a title to user's watchlist with status.
    If already exists, updates the status.
    """
    try:
        await db.execute(
            "CALL save_title($1, $2, $3)",
            current_user.user_id, title_id, request.status
        )
        return SaveTitleResponse(
            success=True,
            message=f"Title saved with status: {request.status}"
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.delete("/{title_id}", response_model=SaveTitleResponse)
async def remove_saved_title(
    title_id: int,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    """
    Remove a title from user's watchlist completely.
    """
    try:
        await db.execute(
            "CALL remove_saved_title($1, $2)",
            current_user.user_id, title_id
        )
        return SaveTitleResponse(
            success=True,
            message="Title removed from watchlist"
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.put("/{title_id}", response_model=SaveTitleResponse)
async def update_saved_status(
    title_id: int,
    request: SaveTitleRequest,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    """
    Update the status of an already saved title.
    """
    try:
        # Check if title exists in watchlist first
        exists = await db.fetchval(
            "SELECT 1 FROM saved WHERE user_id = $1 AND title_id = $2",
            current_user.user_id, title_id
        )
        
        if not exists:
            raise HTTPException(status_code=404, detail="Title not found in watchlist")
        
        await db.execute(
            "CALL save_title($1, $2, $3)",
            current_user.user_id, title_id, request.status
        )
        return SaveTitleResponse(
            success=True,
            message=f"Status updated to: {request.status}"
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))