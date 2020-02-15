FROM ubuntu:18.04

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}

ENV HOME /
USER root

ENV PATH="${PATH}:/home/${NB_USER}/.dotnet/tools"

COPY ./ /home/${USER}/oe-itseclabs/
RUN chown -R ${NB_UID} /home/${NB_USER}

WORKDIR /home/${USER}/oe-itseclabs/.build
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ansible
RUN ansible-playbook --connection=local --inventory localhost, --tags indocker playbook.yml

ENV HOME=/home/${NB_USER}
USER ${USER}
WORKDIR ${HOME}/oe-itseclabs

CMD jupyter lab --ip 0.0.0.0
