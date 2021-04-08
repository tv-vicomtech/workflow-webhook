FROM alpine

RUN apk add --no-cache bash curl openssl xxd jq
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["sh","/entrypoint.sh"]
