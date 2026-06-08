import asyncpg
from app.config import settings

class Database:
    pool: asyncpg.Pool = None

db = Database()

async def connect_db():
    db.pool = await asyncpg.create_pool(
        host=settings.DB_HOST,
        port=settings.DB_PORT,
        user=settings.DB_USER,
        password=settings.DB_PASSWORD,
        database=settings.DB_NAME,
        min_size=1,
        max_size=10
    )
    print("✅ Database connected")

async def disconnect_db():
    if db.pool:
        await db.pool.close()
        print("✅ Database disconnected")

async def get_db():
    async with db.pool.acquire() as conn:
        yield conn