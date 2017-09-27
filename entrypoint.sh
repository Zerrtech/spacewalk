#!/bin/bash

cat <<THE_END > answers.txt
admin-email=$ADMIN_EMAIL
ssl-set-org=$SSL_ORG
ssl-set-org-unit=$SSL_ORG_UNIT
ssl-set-city=$SSL_CITY
ssl-set-state=$SSL_STATE
ssl-set-country=$SSL_COUNTRY
ssl-password=$SSL_PASSWORD
ssl-set-email=$SSL_EMAIL
ssl-config-sslvhost=$SSL_VHOST
db-backend=$DB_BACKEND
db-name=$DB_NAME
db-user=$DB_USER
db-password=$DB_PASSWORD
db-host=$DB_HOST
db-port=$DB_PORT
enable-tftp=$ENABLE_TFTP
hostname=$HOSTNAME
mount-point=$MOUNT_POINT
THE_END

sleep 30

createlang pltclu "$DB_NAME" -h "$DB_HOST" -U postgres

cat answers.txt

spacewalk-setup --answer-file=answers.txt --external-postgresql --skip-services-restart --non-interactive

chown apache.apache -R /var/satellite

mkdir -p /var/run/supervisor && chown -R nobody /var/run/supervisor

supervisord -n -c /etc/supervisord.conf