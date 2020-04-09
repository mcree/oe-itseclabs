FROM ubuntu:18.04

ARG NB_USER=hallgato
ARG NB_UID=10000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}

ENV HOME /
USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-client iputils-ping dnsutils tmux && \
    adduser --uid ${NB_UID} --gecos '' --disabled-password ${NB_USER} && \
    echo "${NB_USER}:${NB_USER}" | chpasswd

ENV HOME=/home/${NB_USER}
USER ${USER}
WORKDIR ${HOME}/

COPY .bash_profile ${HOME}/

ENTRYPOINT ["tmux","-S","/tmux-sock/default"]
