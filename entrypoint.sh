#!/bin/bash
set -e

users="$SFTP_USER"
passwords="$SFTP_PASS"

printf "\n\033[0;44m---> Creating SFTP user.\033[0m\n"

addgroup sftp

for i in "${!users[@]}"; do
  mkdir -p /uploads/${users[i]}/sftp
  useradd -d /uploads/${users[i]} -G sftp ${users[i]} -s /usr/sbin/nologin
  chown ${users[i]}:sftp -R /uploads/${users[i]}/sftp
  echo "${users[i]}:${passwords[i]}" | chpasswd
done

printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"

service ssh start
service ssh status

exec "$@"
