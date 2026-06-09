from fastapi import APIRouter, Depends, HTTPException, Query
from typing import Optional, List
import asyncpg
from app.database import get_db
from app.schemas import SearchResultResponse

router = APIRouter(prefix="/search", tags=["Search"])

@router.get("/titles", response_model=list[SearchResultResponse])
async def search_titles(
    search_text: Optional[str] = None,
    media_type: Optional[str] = Query(None, description="M for movie, S for series"),
    genre_ids: Optional[List[int]] = Query(None, description="Comma-separated genre IDs"),
    min_year: Optional[int] = None,
    max_year: Optional[int] = None,
    min_score: Optional[float] = None,
    min_votes: Optional[int] = None,
    sort_by: str = Query("score_desc", description="score_desc, votes_desc, year_desc, year_asc, title_asc, title_desc"),
    limit: int = 20,
    offset: int = 0,
    user_id: Optional[int] = None,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        """
        SELECT * FROM search_titles(
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
        )
        """,
        search_text, media_type, genre_ids, min_year, max_year,
        min_score, min_votes, sort_by, limit, offset, user_id
    )
    
    if not rows:
        raise HTTPException(status_code=404, detail="No titles found")
    
    return [SearchResultResponse(**dict(row)) for row in rows]