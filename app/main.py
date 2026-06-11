from fastapi import FastAPI
from contextlib import asynccontextmanager
from app.database import connect_db, disconnect_db, get_db
from app.routers import (
    homepage, single, search,
    auth, user, saved, reviews
)
from fastapi.middleware.cors import CORSMiddleware
from apscheduler.schedulers.asyncio import AsyncIOScheduler
from apscheduler.triggers.cron import CronTrigger
from datetime import datetime, timezone

# Global scheduler instance
scheduler = AsyncIOScheduler()

async def refresh_similar_titles_job():
    """Job to refresh similar titles"""
    async for db in get_db():
        try:
            await db.execute("CALL refresh_similar_titles()")
            print(f"✅ Similar titles refreshed at {datetime.now()}")
        except Exception as e:
            print(f"❌ Failed to refresh similar titles: {e}")
        break

@asynccontextmanager
async def lifespan(app: FastAPI):
    await connect_db()

    # Schedule the job to run daily at 2 AM
    scheduler.add_job(
        refresh_similar_titles_job,
        trigger=CronTrigger(day_of_week='fri', hour=4, minute=0),
        id="refresh_similar_titles",
        replace_existing=True
    )
    scheduler.start()
    print("✅ Scheduler started - Similar titles will refresh daily at 2:00 AM")
    
    yield
    scheduler.shutdown()
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