from pydantic import BaseModel, Field
from typing import Optional
from datetime import date

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


class TitleHeaderResponse(BaseModel):
    title_id: int
    name_fa: str
    name_en: Optional[str] = None
    poster_url: Optional[str] = None
    score: Optional[float] = None
    vote_count: Optional[int] = None
    release_date: Optional[date] = None
    end_date: Optional[date] = None
    age_rating: Optional[str] = None
    duration_mins: Optional[int] = None
    genres: Optional[str] = None
    summary: Optional[str] = None
    t_type: str
    total_seasons: Optional[int] = None
    total_episodes: Optional[int] = None
    is_saved: bool = False

class CastMemberResponse(BaseModel):
    person_id: int
    name_fa: str
    name_en: Optional[str] = None
    photo_url: Optional[str] = None
    role_name: str
    character_name_fa: str
    character_name_en: Optional[str] = None
    ordering: Optional[int] = None

class CrewMemberResponse(BaseModel):
    person_id: int
    name_fa: str
    name_en: Optional[str] = None
    photo_url: Optional[str] = None
    role_name: str
    ordering: Optional[int] = None

class AwardResponse(BaseModel):
    award_name: str
    category: str
    ceremony_year: Optional[int] = None
    status: str

class ReviewResponse(BaseModel):
    user_id: int
    username: str
    user_photo: Optional[str] = None
    review_date: Optional[date] = None
    comment: Optional[str] = None
    score: Optional[int] = None
    is_spoiler: bool = False


class SimilarTitleResponse(BaseModel):
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
    similarity_score: Optional[int] = None
    is_saved: bool = False


class SeasonResponse(BaseModel):
    season_number: int
    season_release_date: Optional[date] = None
    season_end_date: Optional[date] = None
    total_episodes: Optional[int] = None


class EpisodeResponse(BaseModel):
    season_number: int
    episode_number: int
    episode_name_fa: str
    episode_name_en: Optional[str] = None
    episode_duration: Optional[int] = None
    episode_release_date: Optional[date] = None
    episode_summary: Optional[str] = None


class SearchResultResponse(BaseModel):
    title_id: int
    t_type: str
    name_fa: str
    name_en: Optional[str] = None
    poster_url: Optional[str] = None
    release_year: Optional[int] = None
    year_end: Optional[int] = None
    score: Optional[float] = None
    vote_count: Optional[int] = None
    genres: Optional[str] = None
    duration_mins: Optional[int] = None
    total_seasons: Optional[int] = None
    total_episodes: Optional[int] = None
    is_saved: bool = False
    total_count: int

class UserRegister(BaseModel):
    username: str
    email: str
    password: str = Field(..., min_length=8, max_length=72)

class UserLogin(BaseModel):
    email: str
    password: str = Field(..., min_length=8, max_length=72)

class TokenResponse(BaseModel):
    access_token: str
    token_type: str
    user_id: int
    username: str
    email: str

class UserResponse(BaseModel):
    user_id: int
    username: str
    email: str
    join_date: date