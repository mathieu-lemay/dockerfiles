FROM debian:10-slim

LABEL maintainer="Mathieu Lemay <acidrain1@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITARM=/opt/devkitpro/devkitARM
ENV PATH=${DEVKITPRO}/tools/bin:$PATH

RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils sudo ca-certificates pkg-config curl \
        wget bzip2 xz-utils make git bsdtar doxygen gnupg zip build-essential \
        python python-dev python-pip python-setuptools zsh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install pycryptodome

RUN wget "https://github.com/devkitPro/pacman/releases/download/v1.0.2/devkitpro-pacman.amd64.deb" && \
    dpkg -i devkitpro-pacman.amd64.deb && \
    rm devkitpro-pacman.amd64.deb && \
    dkp-pacman -Syu --noconfirm switch-dev devkitARM devkitarm-rules \
        switch-portlibs switch-freetype switch-liblzma && \
    yes | dkp-pacman -Scc

ARG LIBNX_COMMIT=

RUN git clone https://github.com/switchbrew/libnx.git && \
    cd libnx && \
    if [ -n "${LIBNX_COMMIT}" ]; then git checkout "${LIBNX_COMMIT}"; fi && \
    make -j12 && \
    make install && \
    cd .. && \
    rm -rf libnx

ARG uid=1000

RUN useradd -d /home/switch -m -u "$uid" -s "/bin/zsh" switch
RUN mkdir /switch

USER switch
WORKDIR /switch
VOLUME /switch

COPY zshrc /home/switch/.zshrc
COPY prompt.zsh /home/switch/.prompt.zsh

CMD /bin/zsh
