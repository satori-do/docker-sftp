#!/bin/bash
set -e

printf "\n\033[0;44m---> Creating SFTP user.\033[0m\n"

addgroup sftp
mkdir /uploads/${SFTP_USER}
mkdir /uploads/${SFTP_USER}/sftp
useradd -d /uploads/${SFTP_USER} -G sftp ${SFTP_USER} -s /usr/sbin/nologin
echo "${SFTP_USER}:${SFTP_PASS}" | chpasswd
chown ${SFTP_USER}:sftp -R /uploads/${SFTP_USER}/sftp

printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"

service ssh start
service ssh status

exec "$@"
