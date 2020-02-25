#!/bin/bash
set -e

users=(${SFTP_USER})
passwords=(${SFTP_PASS})

printf "\n\033[0;44m---> Creating SFTP user.\033[0m\n"

addgroup sftp

for i in "${!users[@]}"; do
  echo Creating user ${users[i]}
  mkdir -p /uploads/${users[i]}/sftp
  useradd -d /uploads/${users[i]} -G sftp ${users[i]} -s /usr/sbin/nologin
  chown root:${users[i]} /uploads/${users[i]}
  chmod 750 /uploads/${users[i]}
  chown ${users[i]}:sftp -R /uploads/${users[i]}/sftp
  echo "${users[i]}:${passwords[i]}" | chpasswd
  echo User ${users[i]} created
done

printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"

mkdir -p /run/sshd

exec "$@"
