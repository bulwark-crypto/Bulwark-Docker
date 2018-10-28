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

To install Docker on Ubuntu, follow [this guide](https://docs.docker.com/install/linux/docker-ce/ubuntu/). See [here](https://docs.docker.com/install/) for info on how to install Docker on other systems. Please note that due to technical limitations, Docker will not run on most OpenVZ VPS - you need a dedicated server or a KVM VPS.

## Starting the image

The Docker image you want to use is _bulwarkcrypto/bulwark:latest_.  
To start a node, run the following command:

```bash
docker container run bulwarkcrypto/bulwark:latest
```

Depending on your needs, you will need to add certain [parameters](https://docs.docker.com/engine/reference/commandline/container_run/#options) to docker, like `-d` to run in the background and `-v` to set a persistent volume for the chaindata. Anything you write after _bulwarkcrypto/bulwark:latest_ will be passed to bulwarkd as a [parameter](https://kb.bulwarkcrypto.com/Information/Running-Bulwark/#command-line-arguments).

## Three ways to run a Docker masternode

### Via command line (not recommended)

```bash
docker container run -d -v NAME:/home/bulwark/.bulwark --name NAME bulwarkcrypto/bulwark:latest  -externalip=ADDRESS -masternode=1 -masternodeaddr=ADDRESS:52543 -masternodeprivkey=KEY -listen=1 -server=1
```

Replace _NAME_, _ADDRESS_ and _KEY_ with your own values. This line will create a container with a persistent storage volume for the chaindata, but it will **not** save parameters like the IP and key, so every time you shut it down and start it back up, you need to pass your parameters again.

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

### Using docker-compose (Easiest option)

The easiest way to run one or more masternodes via Docker is with the use of a [docker-compose](https://docs.docker.com/compose/) file. To use it, you need to [install docker-compose](https://docs.docker.com/compose/install/), and then create a compose file. The easiest way to do that is with our [compose-gen] tool - just enter the name, IP and key for each of the masternodes you want to run on the machine, and a file will be generated for you. Then, all you need to do is run

```bash
docker-compose up -d
```

to start all masternodes listed in the docker-compose.yml file.

If for whatever reason you want to create the file manually, here's an example:

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
  ? NAME
volumes:
  ? NAME
```

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
