FROM alpine:3.18

RUN apk add --no-cache curl unzip bash ca-certificates

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV ARCH=linux_amd64
ENV VERSION=latest
ENV SERVER=""
ENV PASSWORD=""
ENV USE_TLS="false"

ENTRYPOINT ["/entrypoint.sh"]
CMD []
