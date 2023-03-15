FROM python:alpine

LABEL maintainer "Mathieu Lemay <acidrain1@gmail.com>"

ENV MYCLI_VERSION=1.26.1

RUN set -eu; \
    apk add --no-cache bash; \
    pip install --no-cache-dir mycli==${MYCLI_VERSION};

ADD docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["mycli"]
