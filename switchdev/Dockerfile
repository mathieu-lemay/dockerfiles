FROM debian:10-slim

MAINTAINER Mathieu Lemay <acidrain1@gmail.com>

ARG uid=1000

ENV DEBIAN_FRONTEND=noninteractive
ENV DEVKITPRO=/opt/devkitpro
ENV DEVKITARM=/opt/devkitpro/devkitARM
ENV PATH=${DEVKITPRO}/tools/bin:$PATH

RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get install -y --no-install-recommends sudo ca-certificates pkg-config curl \
        wget bzip2 xz-utils make git bsdtar doxygen gnupg zip build-essential \
        python python-dev python-pip python-setuptools zsh && \
    apt-get clean

RUN pip install pycryptodome

RUN wget "https://github.com/devkitPro/pacman/releases/download/devkitpro-pacman-1.0.1/devkitpro-pacman.deb" && \
    dpkg -i devkitpro-pacman.deb && \
    rm devkitpro-pacman.deb && \
    dkp-pacman -Syu --noconfirm switch-dev switch-portlibs switch-freetype devkitARM devkitarm-rules && \
    yes | dkp-pacman -Scc

RUN git clone https://github.com/switchbrew/libnx.git && \
    cd libnx && \
    make -j4 && \
    make install && \
    cd .. && \
    rm -rf libnx

RUN useradd -d /switch -m -u "$uid" -s "/bin/zsh" switch
RUN chown -R "$uid" /switch
RUN echo "zsh-newuser-install() { :; }" >> /etc/zsh/zshenv

USER switch
ENV HOME=/switch
WORKDIR /switch
VOLUME /switch

CMD /bin/zsh
