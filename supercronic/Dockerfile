ARG APP_IMAGE_NAME=cgr.dev/chainguard/wolfi-base
ARG APP_IMAGE_TAG=latest@sha256:441d6709305552a3411e585ad98aacb9dadda00c80f3267483c38ac6f86f49d4

FROM ${APP_IMAGE_NAME}:${APP_IMAGE_TAG} AS build

LABEL maintainer="Mathieu Lemay <acidrain1@gmail.com>"

RUN apk add --no-cache bash curl;

ARG JAQ_VERSION
ARG JAQ_SHA256SUM

# Latest releases available at https://github.com/01mf02/jaq/releases
RUN set -eu; \
    JAQ="jaq-x86_64-unknown-linux-gnu"; \
    JAQ_URL="https://github.com/01mf02/jaq/releases/download/${JAQ_VERSION:?jaq version not specified}/${JAQ}"; \
    JAQ_SHA256SUM="${JAQ_SHA256SUM:?jaq sha256sum not specified}"; \
    \
    curl -fsSLO "${JAQ_URL}"; \
    echo "${JAQ_SHA256SUM}  ${JAQ}" | sha256sum -c -; \
    chmod +x "${JAQ}"; \
    mkdir -p "/usr/local/bin"; \
    mv "${JAQ}" "/usr/local/bin/jaq";


ARG SUPERCRONIC_VERSION
ARG SUPERCRONIC_SHA1SUM

# Latest releases available at https://github.com/aptible/supercronic/releases
RUN set -eu; \
    SUPERCRONIC="supercronic-linux-amd64"; \
    SUPERCRONIC_URL="https://github.com/aptible/supercronic/releases/download/${SUPERCRONIC_VERSION:?supercronic version not specified}/${SUPERCRONIC}"; \
    SUPERCRONIC_SHA1SUM="${SUPERCRONIC_SHA1SUM:?supercronic sha1sum not specified}"; \
    \
    curl -fsSLO "${SUPERCRONIC_URL}"; \
    echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c -; \
    chmod +x "${SUPERCRONIC}"; \
    mkdir -p "/usr/local/bin"; \
    mv "${SUPERCRONIC}" "/usr/local/bin/supercronic";

ENTRYPOINT ["/usr/local/bin/supercronic"]

CMD [ "/etc/crontab" ]
