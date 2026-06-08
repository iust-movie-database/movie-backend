from fastapi import APIRouter, Depends
from app.database import get_db
import asyncpg

router = APIRouter(prefix="/movies", tags=["movies"])

@router.get("/top")
async def get_top_movies(
    limit: int = 5,
    db: asyncpg.Connection = Depends(get_db)
):
    result = await db.fetch("SELECT * FROM get_top_movies(NULL, $1)", limit)
    return [dict(r) for r in result]