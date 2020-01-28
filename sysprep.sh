#/bin/bash
#git config --global user.email "hallgato@itseclabs.local"
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y  dotnet-sdk-3.0 python3-pip nodejs npm
sudo pip3 install pipenv
#in pipenv shell:
dotnet tool install -g dotnet-try
#see: https://devblogs.microsoft.com/dotnet/net-core-with-juypter-notebooks-is-here-preview-1/
pipenv run jupyter contrib nbextension install --user
pipenv run jupyter nbextensions_configurator enable --user
