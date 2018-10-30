# Bulwark-Docker

A collection of Dockerfiles and tools related to the [Bulwark](https://www.bulwarkcrypto.com) project.

## bulwark-node

Creates a working bulwark Linux64 node by installing bulwarkd/bulwark-cli and setting up a user bulwark with the needed configuration. Any parameters you add to the `run` command will be sent to bulwarkd as parameters. Also contains scripts for creating a compose file and setting up the entire Docker environment on an Ubuntu server.

## kovri

Sets up Kovri and configures a Bulwark service.

## tor

Sets up a TOR server and configures it for Bulwark.

## tor-alpine

Sets up a Tor server with Alpine Linux.
