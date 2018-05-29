FROM ubuntu:18.04 AS builder

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y \
    autoconf \
    automake \
    bash \
    bison \
    build-essential \
    ca-certificates \
    cmake \
    doxygen \
    flex \
    git \
    libelf-dev \
    libncurses5-dev \
    libreadline-dev \
    libsdl1.2-dev \
    libtool-bin \
    libusb-dev \
    subversion \
    tcl \
    texinfo \
    unzip \
    wget \
    zlib1g-dev

# libtool complains if /bin/sh is dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN dpkg-reconfigure --frontend=noninteractive dash

ENV PSPDEV "/opt/pspdev"
ENV PSPSDK "$PSPDEV/psp/sdk"
ENV PATH   "${PATH}:$PSPDEV/bin:$PSPSDK/bin"

RUN cd /tmp && \
    git clone https://github.com/pspdev/psptoolchain.git && \
    cd psptoolchain && \
    ./toolchain.sh

RUN find "$PSPDEV/libexec/gcc/psp/4.9.3" -type f -name "*.so*" -exec strip --strip-unneeded '{}' \;
RUN find "$PSPDEV/lib" -maxdepth 1 -type f -name "*.a" -exec strip --strip-debug '{}' \;
RUN find "$PSPDEV/lib/gcc" "$PSPDEV/psp/lib" "$PSPSDK/lib" -type f -name "*.a" -exec psp-strip --strip-debug '{}' \;
RUN find "$PSPDEV/bin" "$PSPDEV/psp/bin" "$PSPDEV/libexec/gcc/psp/4.9.3" -type f ! -name "*.so*" -exec strip --strip-all '{}' \;


FROM ubuntu:18.04

ARG uid

RUN apt-get update && \
    apt-get install --no-install-recommends -y make && \
    useradd -m -d /psp -u $uid psp

ENV HOME /psp
ENV PSPDEV "/opt/pspdev"
ENV PSPSDK "$PSPDEV/psp/sdk"
ENV PATH   "${PATH}:$PSPDEV/bin:$PSPSDK/bin"

COPY --from=builder /opt/pspdev /opt/pspdev

USER psp
WORKDIR /psp
VOLUME /psp

CMD make
