#!/usr/bin/env bash
set -e +x
cd $(dirname $0)
pipenv run jupyter nbextensions_configurator enable --user
pipenv run jupyter labextension install @jupyter-widgets/jupyterlab-manager
touch .flag-sysprep-done
