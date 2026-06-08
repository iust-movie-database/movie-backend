import asyncpg
from typing import Optional
from app.database import get_db
from fastapi import APIRouter, Depends
from app.schemas import (
    HeroResponse, GenreResponse,
    RecommendationResponse,
    TopMovieResponse, TopSeriesResponse,
    ComingSoonResponse
)

router = APIRouter(prefix='/homepage', tags=['homepage'])


from fastapi import APIRouter, Depends, HTTPException
from typing import Optional
import asyncpg
from app.database import get_db
from app.schemas import HeroResponse

router = APIRouter(prefix="/homepage", tags=["Homepage"])


@router.get("/hero", response_model=list[HeroResponse])
async def get_hero(
    user_id: Optional[int] = None,
    limit: int = 1,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_hero_title($1, $2)", 
        user_id, limit
    )
    if not rows:
        raise HTTPException(status_code=404, detail="No hero titles found")
    
    return [HeroResponse(**dict(row)) for row in rows]


@router.get("/popular-genres", response_model=list[GenreResponse])
async def get_popular_genres(
    limit: int = 5,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_popular_genres($1)", 
        limit
    )    
    if not rows:
        raise HTTPException(
            status_code=404,
            detail="No genres found"
        )

    return [GenreResponse(**dict(row)) for row in rows]


@router.get("/recommendations", response_model=list[RecommendationResponse])
async def get_recommendations(
    user_id: int,
    limit: int = 5,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_recommendations($1, $2)",
        user_id, limit
    )
    if not rows:
        raise HTTPException(
            status_code=404,
            detail="No recommendations found for this user"
        )
    
    return [RecommendationResponse(**dict(row)) for row in rows]


@router.get("/top-movies", response_model=list[TopMovieResponse])
async def get_top_movies(
    user_id: Optional[int] = None,
    limit: int = 5,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_top_movies($1, $2)", 
        user_id, limit
    )
    if not rows:
        raise HTTPException(
            status_code=404,
            detail="No movies found"
        )
    
    return [TopMovieResponse(**dict(row)) for row in rows]


@router.get("/top-series", response_model=list[TopSeriesResponse])
async def get_top_series(
    user_id: int = None,
    limit: int = 5,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_top_series($1, $2)",
        user_id, limit
    )
    if not rows:
        raise HTTPException(
            status_code=404,
            detail="No top series found"
        )
    return [TopSeriesResponse(**dict(row)) for row in rows]


@router.get("/coming-soon", response_model=list[ComingSoonResponse])
async def get_coming_soon(
    limit: int = 5,
    user_id: Optional[int] = None,
    db: asyncpg.Connection = Depends(get_db)
):
    rows = await db.fetch(
        "SELECT * FROM get_coming_soon($1, $2)", 
        user_id, limit
    )
    if not rows:
        raise HTTPException(
            status_code=404,
            detail="No upcoming titles found"
        )
    
    return [ComingSoonResponse(**dict(row)) for row in rows]