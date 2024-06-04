from sqlalchemy import create_engine, text
from sqlalchemy.ext.asyncio import AsyncConnection as _AsyncConnection
from sqlalchemy.ext.asyncio import AsyncEngine as _AsyncEngine
from sqlalchemy.util import EMPTY_DICT


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


class AsyncEngine(_AsyncEngine):
    """
    For overriding the connection class used to execute statements.

    This could also be done by changing engine._connection_cls, however this
    is undocumented and probably more fragile so we subclass instead.
    """

    def connect(self):
        return AsyncConnection(self)


class AsyncConnection(_AsyncConnection):
    async def execute(
        self,
        statement,
        parameters=None,
        execution_options=EMPTY_DICT,
        **kwargs
    ):
        """
        Wrap strings in the text type automatically and allows bindparams to be
        passed via kwargs.
        """
        if isinstance(statement, str):
            statement = text(statement)

        if kwargs and parameters is None:
            parameters = kwargs

        return await super().execute(
            statement,
            parameters=parameters,
            execution_options=execution_options
        )
