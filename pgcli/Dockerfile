FROM python:3.12-alpine

LABEL maintainer "Mathieu Lemay <acidrain1@gmail.com>"

ENV PGCLI_VERSION=4.0.1

RUN set -eu; \
    apk add --no-cache bash; \
    pip install --no-cache-dir pgcli==${PGCLI_VERSION} 'psycopg[binary,pool]';

ADD docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

ENV PG_CONNSTR="postgres://postgres:postgres@localhost"

CMD ["pgcli"]
