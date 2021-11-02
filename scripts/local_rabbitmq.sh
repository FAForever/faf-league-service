#!/usr/bin/env bash

RABBITMQ_PID_FILE=/var/lib/rabbitmq/pid
RABBITMQ_DEFAULT_USER=admin
RABBITMQ_DEFAULT_PASS=banana
RABBITMQ_DEFAULT_VHOST=/
MAX_WAIT_SECONDS=30
RABBITMQ_LEAGUE_SERVICE_USER=faf-league-service
RABBITMQ_LEAGUE_SERVICE_PASS=banana
RABBITMQ_LEAGUE_SERVICE_VHOST=/faf-lobby

docker run -d -p 5672:5672 --restart unless-stopped --name faf-rabbitmq rabbitmq:3.8.2-management-alpine

# This doesn't seem to pick up the pid file
docker exec faf-rabbitmq rabbitmqctl wait --timeout ${MAX_WAIT_SECONDS} "${RABBITMQ_PID_FILE}"
# Create RabbitMQ users
docker exec faf-rabbitmq rabbitmqctl add_vhost "${RABBITMQ_LEAGUE_SERVICE_VHOST}"
docker exec faf-rabbitmq rabbitmqctl add_user "${RABBITMQ_LEAGUE_SERVICE_USER}" "${RABBITMQ_LEAGUE_SERVICE_PASS}"
docker exec faf-rabbitmq rabbitmqctl set_permissions -p "${RABBITMQ_LEAGUE_SERVICE_VHOST}" "${RABBITMQ_LEAGUE_SERVICE_USER}" ".*" ".*" ".*"


