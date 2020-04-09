FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add --update acf-openssh && \
    adduser -u 10000 -g '' -D hallgato && \
    echo "hallgato:hallgato" | chpasswd

COPY ssh/sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
