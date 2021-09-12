#!/bin/bash

DOMAIN=$1
EMAIL=$2
NGINX_CONTAINER='teampass-proxy'
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COMPOSE_DIR=${SCRIPT_DIR%"/certbot/scripts"}
CERTBOT_DIR=${COMPOSE_DIR}/certbot


printf '####################\n'
date
check_docker=1
check_pem=2

printf '########## Start certificate renewal process...\n'

sudo cp ${CERTBOT_DIR}/etc/live/${DOMAIN}/cert.pem ${CERTBOT_DIR}/last-cert.pem

docker run --rm --name certbot \
    --env-file ${SCRIPT_DIR}/.env.certbot \
    -v "${CERTBOT_DIR}/etc:/etc/letsencrypt" \
    -v "${CERTBOT_DIR}/lib:/var/lib/letsencrypt" \
    -v "${CERTBOT_DIR}/log:/var/log" \
    certbot/dns-route53 certonly --logs-dir /var/log \
    --agree-tos --email $EMAIL --non-interactive --dns-route53 -d $DOMAIN --cert-name $DOMAIN
check_docker=$?

check_pem=$(sudo cmp -s "${CERTBOT_DIR}/etc/live/${DOMAIN}/cert.pem" "${CERTBOT_DIR}/last-cert.pem"; echo $?)

if [[ $check_pem -eq 1 && $check_docker -eq 0 ]]; then
    printf '########## Reloading nginx...\n'
    docker container exec $NGINX_CONTAINER nginx -s reload

    if [ "$?" -eq 0 ]; then
        printf 'Certificate renewed.\n\n\n'
        exit 0
    else
        printf 'Problem to reloading proxy.\n\n\n'
        exit 1
    fi

elif [[ $check_pem -eq 0 && $check_docker -eq 0 ]]; then
    printf 'Certificate is already up-to-date.\n\n\n'
    exit 0
else
    printf 'ERROR: certificate renewal process failed.\n\n\n'
    exit 1
fi
