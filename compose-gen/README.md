# compose-gen

## Description

A shell script that allows you to create a docker-compose file for any number of masternodes.

To run the script, paste the following line into a terminal and press Enter:

```bash
bash <(wget -qO- https://git.bulwarkcrypto.com/kewagi/Bulwark-Docker/raw/branch/master/compose-gen/compose-gen.sh)
```

The script will ask you for three pieces of information:

- **Name:** Any name you want to use for the node. Must contain only alphanumeric characters.
- **Address:** The external IP address your masternode should use. Usually the main IP of the VPS.
- **Key:** The masternode key. You can generate one in the debug console of your wallet with the command `masternode genkey`.

After you enter those, it will ask if you want to add another node. The process will repeat for every additional node.

Once done, you will be left with a file called `docker-compose.yml` inside a folder called `bulwark-mn`.  
This file contains all the information needed for docker to start your node(s).

## Prerequisites

You need to make sure Docker is installed - follow the [official installation guide](https://docs.docker.com/install/linux/docker-ce/ubuntu/), then install docker-compose:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Running docker-compose

From inside the bulwark-mn directory, run the following command to start:

```bash
docker-compose up -d
```

The `-d` parameter tells docker to run the container(s) in the background.

To stop, run this:

```bash
docker-compose down
```

## Updating docker-compose containers

To update your containers to a newer release of Bulwark, run these commands inside the bulwark-mn directory:

```bash
docker-compose down
docker-compose pull
docker-compose up -d
```

## Running bulwark-cli inside a container

To run bulwark-cli inside a container to check your sync status or do other things, you need to address the container by name. You can find out by running

```bash
docker container ls
```

To run bulwark-cli inside a specific container, run

```bash
docker container exec NAME_OF_CONTAINER bulwark-cli
```

## Troubleshooting

If bulwarkd cannot start because of corrupted chaindata, you can delete the associated storage volume(s) and restart by running

```bash
docker-compose down -v
docker-compose up
```

This will resync your node(s) and fix any corruption issues.
