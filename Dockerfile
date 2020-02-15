FROM ubuntu:18.04

ARG NB_USER
ARG NB_UID

ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

COPY ./ /work/
WORKDIR /work/build

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install ansible && \
    ansible-playbook --connection=local --inventory localhost, --tags indocker playbook.yml

WORKDIR ${HOME}
