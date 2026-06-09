from fastapi import APIRouter, Depends, HTTPException
from typing import Optional
import asyncpg
from app.database import get_db
from app.schemas import (
    TitleHeaderResponse, CastMemberResponse,
    CrewMemberResponse, AwardResponse,
    ReviewResponse, SimilarTitleResponse,
    SeasonResponse, EpisodeResponse, UserResponse
)
from app.core.deps import get_current_user_optional

router = APIRouter(prefix="/single", tags=["Single Title"])


@router.get("/{title_id}", response_model=TitleHeaderResponse)
async def get_title_header(
    title_id: int,
    db: asyncpg.Connection = Depends(get_db),
    current_user: Optional[UserResponse] = Depends(get_current_user_optional)
):
    user_id = current_user.user_id if current_user else None
    row = await db.fetchrow(
        "SELECT * FROM get_title_header($1, $2)", 
        title_id, user_id
    )
    if not row:
        raise HTTPException(status_code=404, detail="Title not found")
    return TitleHeaderResponse(**dict(row))


@router.get("/{title_id}/cast", response_model=list[CastMemberResponse])
async def get_title_cast(
    title_id: int,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_title_cast($1)", 
        title_id
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No cast found for this title")
    return [CastMemberResponse(**dict(row)) for row in rows]


@router.get("/{title_id}/crew", response_model=list[CrewMemberResponse])
async def get_title_crew(
    title_id: int,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_title_crew($1)", 
        title_id
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No crew found for this title")
    return [CrewMemberResponse(**dict(row)) for row in rows]


@router.get("/{title_id}/awards", response_model=list[AwardResponse])
async def get_title_awards(
    title_id: int,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_title_awards($1)", 
        title_id
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No awards found for this title")
    return [AwardResponse(**dict(row)) for row in rows]


@router.get("/{title_id}/reviews", response_model=list[ReviewResponse])
async def get_title_reviews(
    title_id: int,
    limit: int = 10,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_title_reviews($1, $2)", 
        title_id, limit
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No reviews found for this title")
    return [ReviewResponse(**dict(row)) for row in rows]


@router.get("/{title_id}/similar", response_model=list[SimilarTitleResponse])
async def get_similar_titles(
    title_id: int,
    limit: int = 10,
    db: asyncpg.Connection = Depends(get_db),
    current_user: Optional[UserResponse] = Depends(get_current_user_optional)
):
    user_id = current_user.user_id if current_user else None
    rows = await db.fetch(
        "SELECT * FROM get_similar_titles($1, $2, $3)", 
        title_id, user_id, limit
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No similar titles found")
    return [SimilarTitleResponse(**dict(row)) for row in rows]


@router.get("/{title_id}/seasons", response_model=list[SeasonResponse])
async def get_series_seasons(
    title_id: int,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_series_seasons($1)", 
        title_id
    )    
    if not rows:
        raise HTTPException(status_code=404, detail="No seasons found for this series")
    return [SeasonResponse(**dict(row)) for row in rows]


@router.get("/{title_id}/episodes", response_model=list[EpisodeResponse])
async def get_series_episodes(
    title_id: int,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_series_episodes($1)", 
        title_id
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No episodes found for this title")
    return [EpisodeResponse(**dict(row)) for row in rows]