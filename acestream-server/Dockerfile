FROM debian:10-slim

RUN set -eu; \
    apt-get update; \
    apt-get install -yq --no-install-recommends \
        curl \
        ca-certificates \
        libpython2.7 \
        net-tools \
        python-minimal \
        python-apsw \
        python-lxml \
        python-m2crypto \
        python-pkg-resources \
        python-requests; \
    rm -rf /var/lib/apt/lists/*

# https://docs.acestream.net/products/#linux
RUN set -eu; \
    mkdir -p /opt/acestream; \
    curl --silent "https://download.acestream.media/linux/acestream_3.1.74_debian_10.5_x86_64.tar.gz" \
        | tar --extract --gzip -C /opt/acestream;

CMD /opt/acestream/acestreamengine --client-console
