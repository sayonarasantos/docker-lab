#!/bin/bash

DOMAIN=$1
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COMPOSE_DIR=${SCRIPT_DIR%"/certbot/scripts"}
CERTBOT_DIR=${COMPOSE_DIR}/certbot


docker run --rm -it --name certbot \
    --env-file ${SCRIPT_DIR}/.env.certbot \
    -v "${CERTBOT_DIR}/etc:/etc/letsencrypt" \
    -v "${CERTBOT_DIR}/lib:/var/lib/letsencrypt" \
    -v "${CERTBOT_DIR}/log:/var/log" \
    certbot/certbot certonly --logs-dir /var/log \
    --manual --preferred-challenges=dns -d $DOMAIN
