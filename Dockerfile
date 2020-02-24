FROM debian:9.5

ARG SFTP_USER=user
ARG SFTP_PASS=password

ENV SFTP_USER=$SFTP_USER
ENV SFTP_PASS=$SFTP_PASS

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    nano \
    openssh-server

RUN mkdir /uploads

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD tail -f /dev/null
