# Bulwark Docker Node

## Description

Bulwark offers [Docker](https://www.docker.com/) images of the bulwark node. Click [here](https://medium.com/@Jernfrost/a-short-explanation-of-what-docker-and-containers-are-b65974130683) to learn more about Docker.

### Terminology

- **Image:** A template for a unit of software that is used to generate containers.
- **Container:** A standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another.
- **Volume:** Persistent storage attached to a container. It keeps existing even when the container is destroyed.

## Prerequisites

### One unique IP per container

Every Docker container requires its own unique IP address to work. This can be either an IPv4 or IPv6 address.

### Docker

To install Docker on Ubuntu 14/16/18, follow these [instructions](https://docs.docker.com/install/linux/docker-ce/ubuntu/):

#### Uninstall old versions and update your repositories

```bash
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
```

#### **Ubuntu 14.04 only:** Install additional storage drivers

```bash
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
```

#### Set up dependencies

```bash
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
```

#### Add and verify the Docker GPG key

```bash
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 sudo apt-key fingerprint 0EBFCD88
```

The output from this command should look like this:

```text
pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
```

#### Add Docker repository

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

This assumes you want to install the packages for an x86_64 or AMD64 architecture. For other architectures, check the [official guide](https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository).

#### Install Docker

```bash
sudo apt-get update
sudo apt-get install docker-ce
```

#### Installing Docker on different host systems

See [here](https://docs.docker.com/install/) for info on how to install Docker on other systems. Please note that due to technical limitations, Docker will not run on most OpenVZ VPS - you need a dedicated server or a KVM VPS.

## Three ways to run a Docker masternode

### Using docker-compose (Easiest option)

The easiest way to run one or more masternodes via Docker is with the use of a [docker-compose](https://docs.docker.com/compose/) file. To use it, you need to [install docker-compose](https://docs.docker.com/compose/install/), and then create a compose file. The easiest way to do that is with our compose-gen script for Linux.

To create said file, run the following command:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/bulwark-crypto/Bulwark-Docker/master/bulwark-node/scripts/compose-gen.sh)
```

After you've created your file, install docker-compose by running the following commands:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

Then, all you need to do is run

```bash
docker-compose up -d
```

inside the directory containing your docker-compose.yml file (called `bulwark-mn` by default) to start all masternodes listed.

### Using bulwark.conf (For a single node)

The Bulwark image comes with the nano text editor pre-installed, so if you want, you can start the node with a command like

```bash
docker container run -d -v NAME:/home/bulwark/.bulwark --name NAME bulwarkcrypto/bulwark:latest
```

and then edit your bulwark.conf by running

```bash
docker container exec -it NAME nano /home/bulwark/.bulwark/bulwark.conf
```

Then, restart your container with `docker container restart NAME`  
bulwarkd will restart and use the settings from bulwark.conf, which will persist unless you delete the volume.

### Via command line (not recommended)

```bash
docker container run -d -v NAME:/home/bulwark/.bulwark --name NAME bulwarkcrypto/bulwark:latest  -externalip=ADDRESS -masternode=1 -masternodeaddr=ADDRESS:52543 -masternodeprivkey=KEY -listen=1 -server=1
```

Replace _NAME_, _ADDRESS_ and _KEY_ with your own values.

- **NAME:** Any name you want to use for the node. Must contain only alphanumeric characters.
- **ADDRESS:** The external IP address your masternode should use. Usually the main IP of the VPS.
- **KEY:** The masternode key. You can generate one in the debug console of your wallet with the command `masternode genkey`.

This line will create a container with a persistent storage volume for the chaindata, but it will **not** save parameters like the IP and key, so every time you shut it down and start it back up, you need to pass your parameters again.

## Updating a node

### Non-compose node

To update a non-compose node to the newest version of Bulwark, run these commands:

```bash
docker container stop NAME
docker image pull bulwarkcrypto/bulwark:latest
docker container run bulwarkcrypto/bulwark:latest
```

Please note that unless you manually added your configuration to bulwark.conf, you will need to start your node with the parameters you used before. Also, make sure to assign the same volume to the container with the `-v` parameter to keep your chaindata.

### docker-compose

Since the docker-compose file keeps all your configuration, simply run these three commands to update:

```bash
docker-compose down
docker-compose pull
docker-compose up
```

## Technical information

### Image

The Docker image you want to use is _bulwarkcrypto/bulwark:latest_.

### Entrypoint

The entrypoint script passes anything you add to the `docker run` statement as a [parameter](https://kb.bulwarkcrypto.com/Information/Running-Bulwark/#command-line-arguments) to bulwarkd.

## docker-compose.yml example

```yaml
version: "3.7"
services:
  NAME:
    container_name: NAME
    command:
      [
        "-masternode=1",
        "-masternodeaddr=[ADDRESS]:52543",
        "-masternodeprivkey=87654321abcdef",
        "-listen=1",
        "-server=1",
      ]
    healthcheck:
      test: ["CMD", "bulwark-cli", "getinfo"]
      interval: 10m
      timeout: 30s
      retries: 3
    image: bulwarkcrypto/bulwark:latest
    networks:
      - NAME
    ports:
      - "ADDRESS:52543:52543"
    volumes:
      - NAME:/home/bulwark/.bulwark

networks:
  NAME:
volumes:
  NAME:
```

# Additional scripts

## compose-gen

### Description

A shell script that allows you to create a docker-compose file for any number of masternodes.

To run the script, paste the following line into a terminal and press Enter:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/bulwark-crypto/Bulwark-Docker/master/bulwark-node/scripts/compose-gen.sh)
```

The script will ask you for three pieces of information:

- **Name:** Any name you want to use for the node. Must contain only alphanumeric characters.
- **Address:** The external IP address your masternode should use. Usually the main IP of the VPS.
- **Key:** The masternode key. You can generate one in the debug console of your wallet with the command `masternode genkey`.

After you enter those, it will ask if you want to add another node. The process will repeat for every additional node.

Once done, you will be left with a file called `docker-compose.yml` inside a folder called `bulwark-mn`.  
This file contains all the information needed for docker to start your node(s).

### Prerequisites

You need to make sure Docker is installed - follow the [official installation guide](https://docs.docker.com/install/linux/docker-ce/ubuntu/), then install docker-compose:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### Running docker-compose

From inside the bulwark-mn directory, run the following command to start:

```bash
docker-compose up -d
```

The `-d` parameter tells docker to run the container(s) in the background.

To stop, run this:

```bash
docker-compose down
```

### Updating docker-compose containers

To update your containers to a newer release of Bulwark, run these commands inside the bulwark-mn directory:

```bash
docker-compose down
docker-compose pull
docker-compose up -d
```

### Running bulwark-cli inside a container

To run bulwark-cli inside a container to check your sync status or do other things, you need to address the container by name. You can find out by running

```bash
docker container ls
```

To run bulwark-cli inside a specific container, run

```bash
docker container exec NAME_OF_CONTAINER bulwark-cli
```

### Troubleshooting

If bulwarkd cannot start because of corrupted chaindata, you can delete the associated storage volume(s) and restart by running

```bash
docker-compose down -v
docker-compose up
```

This will resync your node(s) and fix any corruption issues.

## ubuntu-docker-mn.sh

To install docker and docker-compose and create a compose file on your X86 VPS running Ubuntu 16.04 or higher, run this command:

```bash
wget -qO- https://raw.githubusercontent.com/bulwark-crypto/Bulwark-Docker/master/bulwark-node/scripts/ubuntu-docker-mn.sh | bash
```
