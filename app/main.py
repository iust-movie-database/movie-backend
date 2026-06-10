from fastapi import FastAPI
from contextlib import asynccontextmanager
from app.database import connect_db, disconnect_db
from app.routers import (
    homepage, single, search,
    auth, user, saved, reviews
)
from fastapi.middleware.cors import CORSMiddleware

@asynccontextmanager
async def lifespan(app: FastAPI):
    await connect_db()
    yield
    await disconnect_db()

app = FastAPI(title="Movie Database API", lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(homepage.router)
app.include_router(single.router)
app.include_router(search.router)
app.include_router(auth.router)
app.include_router(user.router)
app.include_router(saved.router)
app.include_router(reviews.router)

@app.get("/")
async def root():
    return {"message": "Movie Database API", "status": "running"}