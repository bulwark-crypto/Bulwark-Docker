#!/bin/bash

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

mkdir ./bulwark-mn && cd ./bulwark-mn || exit 1

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

cat >> ~/.bashrc << EOL

# Alias shortcuts for Docker masternodes

EOL

for i in "${!NAMES[@]}"; do
echo "alias ${NAMES[$i]}='docker container exec -it ${NAMES[$i]}'" >> ~/.bashrc 
done 

source ~/.bashrc

cat << EOL

Setup complete. You can now start your node(s) with: 

cd bulwark-mn
docker-compose up -d

Alias commands for all your masternodes have been installed. To run a command
inside your masternode, just call it with its name. For example, if you want 
to run getinfo inside your masternode "mn1", run this command:

mn1 getinfo

EOL