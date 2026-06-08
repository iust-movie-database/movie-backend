from pydantic import BaseModel
from typing import Optional

class HeroResponse(BaseModel):
    title_id: int
    name_fa: str
    name_en: Optional[str] = None
    poster_url: Optional[str] = None
    genres: Optional[str] = None
    score: Optional[float] = None
    release_year: Optional[int] = None
    age_rating: Optional[str] = None
    summary: Optional[str] = None
    t_type: str
    duration_mins: Optional[int] = None
    total_seasons: Optional[int] = None
    total_episodes: Optional[int] = None
    end_year: Optional[int] = None
    is_saved: bool = False

class GenreResponse(BaseModel):
    genre_id: int
    genre_name: str
    title_count: int

class RecommendationResponse(BaseModel):
    title_id: int
    t_type: str
    score: Optional[float] = None
    age_rating: Optional[str] = None
    name_fa: str
    name_en: Optional[str] = None
    poster_url: Optional[str] = None
    genres: Optional[str] = None
    release_year: Optional[int] = None
    duration_mins: Optional[int] = None
    total_seasons: Optional[int] = None
    total_episodes: Optional[int] = None
    end_year: Optional[int] = None
    is_saved: bool = False

class TopMovieResponse(BaseModel):
    title_id: int
    t_type: str
    score: Optional[float] = None
    age_rating: Optional[str] = None
    name_fa: str
    name_en: Optional[str] = None
    poster_url: Optional[str] = None
    genres: Optional[str] = None
    release_year: Optional[int] = None
    duration_mins: Optional[int] = None
    is_saved: bool = False

class TopSeriesResponse(BaseModel):
    title_id: int
    t_type: str
    score: Optional[float] = None
    age_rating: Optional[str] = None
    name_fa: str
    name_en: Optional[str] = None
    poster_url: Optional[str] = None
    genres: Optional[str] = None
    release_year: Optional[int] = None
    end_year: Optional[int] = None
    total_episodes: Optional[int] = None
    is_saved: bool = False

class ComingSoonResponse(BaseModel):
    title_id: int
    t_type: str
    age_rating: Optional[str] = None
    name_fa: str
    name_en: Optional[str] = None
    poster_url: Optional[str] = None
    genres: Optional[str] = None
    release_year: Optional[int] = None
    duration_mins: Optional[int] = None
    total_seasons: Optional[int] = None
    total_episodes: Optional[int] = None
    is_saved: bool = False