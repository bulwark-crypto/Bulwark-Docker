#!/bin/dash
echo "HELLO DEBUG"
mkdir ~/.bulwark
touch ~/.bulwark/bulwark.conf

if ! grep rpcpassword ~/.bulwark/bulwark.conf; then
  RPCUSER="bulwarkrpc"
  RPCPASSWORD=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
  touch ~/.bulwark/bulwark.conf
  echo "rpcuser=${RPCUSER}" >> ~/.bulwark/bulwark.conf
  echo "rpcpassword=${RPCPASSWORD}" >> ~/.bulwark/bulwark.conf
fi
/bin/bulwarkd -printtoconsole