#!/usr/bin/env bash
#
# this script must be run unprivileged
#
cd "$(dirname $0)"
[[ -f ".flag-sysprep-done" ]] && exit 0
set -e +x
pipenv update
pipenv run dotnet tool install -g dotnet-script
pipenv run dotnet tool install -g --add-source "https://dotnet.myget.org/F/dotnet-try/api/v3/index.json" Microsoft.dotnet-interactive
pipenv run dotnet interactive jupyter install
pipenv run jupyter contrib nbextension install --user
pipenv run jupyter serverextension enable --py jupyterlab_git
pipenv run jupyter nbextensions_configurator enable --user
pipenv run jupyter labextension install @jupyter-widgets/jupyterlab-manager
pipenv run jupyter labextension install @jupyterlab/git
pipenv run jupyter lab build
touch .flag-sysprep-done
exit 0
