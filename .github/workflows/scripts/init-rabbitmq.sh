#!/usr/bin/env bash

MAX_WAIT_SECONDS=60
RABBITMQ_PID_FILE=/var/lib/rabbitmq/pid

RABBITMQ_LEAGUE_SERVICE_USER=faf-league-service
RABBITMQ_LEAGUE_SERVICE_PASS=banana
RABBITMQ_LEAGUE_SERVICE_VHOST=/faf-lobby

# Create RabbitMQ users
docker exec faf-rabbitmq rabbitmqctl wait --timeout ${MAX_WAIT_SECONDS} "${RABBITMQ_PID_FILE}"

docker exec faf-rabbitmq rabbitmqctl add_vhost "${RABBITMQ_LEAGUE_SERVICE_VHOST}"
docker exec faf-rabbitmq rabbitmqctl add_user "${RABBITMQ_LEAGUE_SERVICE_USER}" "${RABBITMQ_LEAGUE_SERVICE_PASS}"
docker exec faf-rabbitmq rabbitmqctl set_permissions -p "${RABBITMQ_LEAGUE_SERVICE_VHOST}" "${RABBITMQ_LEAGUE_SERVICE_USER}" ".*" ".*" ".*"
