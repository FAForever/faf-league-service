from sqlalchemy import create_engine
from sqlalchemy.ext.asyncio import AsyncEngine


class FAFDatabase:
    def __init__(
        self,
        host: str = "localhost",
        port: int = 3306,
        user: str = "root",
        password: str = "",
        db: str = "faf_test",
        **kwargs
    ):
        kwargs["future"] = True
        sync_engine = create_engine(
            f"mysql+aiomysql://{user}:{password}@{host}:{port}/{db}",
            **kwargs
        )

        self.engine = AsyncEngine(sync_engine)

    def acquire(self):
        return self.engine.begin()

    async def close(self):
        await self.engine.dispose()