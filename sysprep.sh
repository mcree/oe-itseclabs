#/bin/bash
#git config --global user.email "hallgato@itseclabs.local"
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y  dotnet-sdk-3.0 python3-pip
sudo pip3 install pipenv
dotnet tool install -g dotnet-try
