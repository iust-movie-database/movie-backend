from fastapi import APIRouter, Depends, HTTPException
import asyncpg
from app.database import get_db
from app.schemas import ReviewRequest, CUDReviewResponse, UserResponse
from app.core.deps import get_current_user

router = APIRouter(prefix="/reviews", tags=["Reviews"])

@router.post("/{title_id}", response_model=CUDReviewResponse)
async def add_or_update_review(
    title_id: int,
    request: ReviewRequest,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    """
    Add a new review or update existing review for a title.
    """
    # Validate score range
    if request.score < 1 or request.score > 10:
        raise HTTPException(status_code=400, detail="Score must be between 1 and 10")
    
    try:
        await db.execute(
            "CALL add_review($1, $2, $3, $4, $5)",
            current_user.user_id, title_id, request.score, request.comment, request.is_spoiler
        )
        return CUDReviewResponse(
            success=True,
            message="Review saved successfully"
        )
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.delete("/{title_id}", response_model=CUDReviewResponse)
async def delete_review(
    title_id: int,
    current_user: UserResponse = Depends(get_current_user),
    db: asyncpg.Connection = Depends(get_db)
):
    """
    Delete a review completely.
    """
    try:
        # Check if review exists
        exists = await db.fetchval(
            "SELECT 1 FROM review WHERE user_id = $1 AND title_id = $2",
            current_user.user_id, title_id
        )
        
        if not exists:
            raise HTTPException(status_code=404, detail="Review not found")
        
        await db.execute(
            "CALL remove_review($1, $2)",
            current_user.user_id, title_id
        )
        return CUDReviewResponse(
            success=True,
            message="Review deleted successfully"
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))