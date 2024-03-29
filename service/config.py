import logging
import os

# Logging setup
TRACE = 5
logging.addLevelName(TRACE, "TRACE")
logging.getLogger("aio_pika").setLevel(logging.INFO)

LOG_LEVEL = os.getenv("LOG_LEVEL", "DEBUG")

DB_SERVER = os.getenv("DB_SERVER", "127.0.0.1")
DB_PORT = int(os.getenv("DB_PORT", 3306))
DB_LOGIN = os.getenv("DB_LOGIN", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "banana")
DB_NAME = os.getenv("DB_NAME", "faf-league")

MQ_USER = os.getenv("MQ_USER", "faf-league-service")
MQ_PASSWORD = os.getenv("MQ_PASSWORD", "banana")
MQ_SERVER = os.getenv("MQ_SERVER", "localhost")
MQ_PORT = int(os.getenv("MQ_PORT", 5672))
MQ_VHOST = os.getenv("MQ_VHOST", "/faf-lobby")
MQ_PREFETCH_COUNT = int(os.getenv("MQ_PREFETCH_COUNT", 300))

SEASON_GENERATION_DAYS_BEFORE_SEASON_END = int(os.getenv("SEASON_GENERATION_DAYS_BEFORE_SEASON_END", 14))
SEASON_LENGTH_MONTHS = int(os.getenv("SEASON_LENGTH_MONTHS", 3))

EXCHANGE_NAME = os.getenv("EXCHANGE_NAME", "faf-rabbitmq")
QUEUE_NAME = os.getenv("QUEUE_NAME", "faf-league-service")
TRUESKILL_RATING_UPDATE_ROUTING_KEY = os.getenv(
    "TRUESKILL_RATING_UPDATE_ROUTING_KEY", "success.rating.update"
)
LEAGUE_SCORE_UPDATE_ROUTING_KEY = os.getenv(
    "LEAGUE_SCORE_UPDATE_ROUTING_KEY", "success.leagueScore.update"
)
LEAGUE_SCORE_UPDATE_FAIL_ROUTING_KEY = os.getenv(
    "LEAGUE_SCORE_UPDATE_FAIL_ROUTING_KEY", "failure.leagueScore.update"
)

RATING_MODIFIER_FOR_PLACEMENT = int(os.getenv("RATING_MODIFIER_FOR_PLACEMENT", -100))
SCORE_GAIN = int(os.getenv("SCORE_GAIN", 1))
POSITIVE_BOOST = int(os.getenv("POSITIVE_BOOST", 1))
NEGATIVE_BOOST = int(os.getenv("NEGATIVE_BOOST", 1))
HIGHEST_DIVISION_BOOST = int(os.getenv("HIGHEST_DIVISION_BOOST", 1))
POINT_BUFFER_AFTER_DIVISION_CHANGE = int(
    os.getenv("POINT_BUFFER_AFTER_DIVISION_CHANGE", 2)
)
