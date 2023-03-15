FROM devkitpro/toolchain-base

LABEL maintainer="Mathieu Lemay <acidrain1@gmail.com>"

RUN set -eu; \
    apt-get update; \
    apt-get install -y --no-install-recommends zsh; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

RUN set -eu; \
    ln -s /proc/self/mounts /etc/mtab; \
    dkp-pacman -Syyu --noconfirm switch-dev switch-portlibs devkitARM; \
    yes | dkp-pacman -Scc

ARG uid=1000

COPY sudoers /etc/sudoers
RUN set -eu; \
    chmod 440 /etc/sudoers; \
    mkdir /switch; \
    useradd -d /home/switch -m -u "$uid" -s "/bin/zsh" switch

USER switch
WORKDIR /switch
VOLUME /switch

COPY zshrc /home/switch/.zshrc
COPY prompt.zsh /home/switch/.prompt.zsh

CMD /bin/zsh
