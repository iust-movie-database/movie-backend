from fastapi import FastAPI
from contextlib import asynccontextmanager
from app.database import connect_db, disconnect_db
from app.routers import (
    homepage, single, search,
    auth
)

@asynccontextmanager
async def lifespan(app: FastAPI):
    await connect_db()
    yield
    await disconnect_db()

app = FastAPI(title="Movie Database API", lifespan=lifespan)

app.include_router(homepage.router)
app.include_router(single.router)
app.include_router(search.router)
app.include_router(auth.router)

@app.get("/")
async def root():
    return {"message": "Movie Database API", "status": "running"}