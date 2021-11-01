#!/usr/bin/env bash

RABBITMQ_PID_FILE=/var/lib/rabbitmq/pid
RABBITMQ_DEFAULT_USER=admin
RABBITMQ_DEFAULT_PASS=banana
RABBITMQ_DEFAULT_VHOST=/

docker run --rm -d -p 5672:5672  --name faf-rabbitmq rabbitmq:3.8.2-management-alpine

sh ./.github/workflows/scripts/init-rabbitmq.sh

