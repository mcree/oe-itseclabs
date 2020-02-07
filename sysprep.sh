#!/usr/bin/env bash
set -e +x
cd $(dirname $0)
pipenv run jupyter serverextension enable --py jupyterlab_git
pipenv run jupyter nbextensions_configurator enable --user
pipenv run jupyter labextension install @jupyter-widgets/jupyterlab-manager
pipenv run jupyter labextension install @jupyterlab/git
pipenv run jupyter lab build
touch .flag-sysprep-done
