#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

clear

cat << EOL
--------------------- Bulwark Docker Masternode Installer ---------------------

This script will install Docker and docker-compose on your Ubuntu server. 
Please note that you will need one generated key and one unique IP address 
per masternode that you want to set up.

EOL

read -rp "Press Ctrl-C to stop or any other key to continue."

echo "Checking for and removing old versions of Docker..."
sudo apt-get remove docker docker-engine docker.io
echo "Updating apt repositories..."
sudo apt-get update
echo "Installing prerequisite packages..."
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "Adding Docker repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo "Fetching new packages..."
sudo apt-get update
echo "Installing Docker Community Edition..."
sudo apt-get -y install docker-ce
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "Testing installation..."
docker -v || exit 1
docker-compose -v || exit 1
echo "Creating bulwark-mn directory..."
cat << EOL

Docker setup completed. We will now ask for your masternode details to create
a docker-compose file you can use to start your masternodes. This file will be
created inside a folder called "bulwark-mn" in the directory where you ran the 
setup script - $(pwd) 

EOL
read -rp "Press any key to continue."
clear
mkdir ./bulwark-mn && cd ./bulwark-mn || exit 1

read -rp "Please enter the name of your node: " NAME
NAMES+=("$NAME")

read -rp "Please enter the IP adddress of your node: " IP
IPS+=("$IP")

read -rp "Please enter the masternode key: " KEY
KEYS+=("$KEY")

read -rp "Add another node? [y/n] " REPLY

while [[ $REPLY =~ ^[yY]$ ]]; do
  read -rp "Please enter the name of your node: " NAME
  NAMES+=("$NAME")
  read -rp "Please enter the IP adddress of your node: " IP
  IPS+=("$IP")
  read -rp "Please enter the masternode key: " KEY
  KEYS+=("$KEY")
  read -rp "Add another node? [y/n] " REPLY
done

echo "Writing docker-compose.yml file..."

echo 'version: "3.7"' > docker-compose.yml
echo 'services:' >> docker-compose.yml

for i in "${!NAMES[@]}"; do
cat >> docker-compose.yml << EOL
  ${NAMES[$i]}:
    command:
      [
        "-masternode=1",
        "-masternodeaddr=[${IPS[$i]}]:52543",
        "-masternodeprivkey=${KEYS[$i]}",
        "-listen=1",
        "-server=1",
      ]
    container_name: ${NAMES[$i]}
    healthcheck:
      test: ["CMD", "bulwark-cli", "getinfo"]
      interval: 10m
      timeout: 30s
      retries: 3
    image: bulwarkcrypto/bulwark:latest
    networks:
      - ${NAMES[$i]}
    ports:
      - "${IPS[$i]}:52543:52543"
    volumes:
      - ${NAMES[$i]}:/home/bulwark/.bulwark

EOL
done

echo 'networks:' >> docker-compose.yml
for i in "${!NAMES[@]}"; do
echo "  ? ${NAMES[$i]}" >> docker-compose.yml
done 
echo "" >> docker-compose.yml

echo 'volumes:' >> docker-compose.yml
for i in "${!NAMES[@]}"; do
echo "  ? ${NAMES[$i]}" >> docker-compose.yml
done 

clear

cat << EOL

Setup complete. You can now start your node(s) with: 

cd bulark-mn
docker-compose up

EOL