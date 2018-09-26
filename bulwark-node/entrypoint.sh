#!/bin/dash
if ! grep rpcpassword /home/bulwark/.bulwark/bulwark.conf; then
  RPCUSER="bulwarkrpc"
  RPCPASSWORD=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
  echo "rpcuser=${RPCUSER}" > /home/bulwark/.bulwark/bulwark.conf
  echo "rpcpassword=${RPCPASSWORD}" >> /home/bulwark/.bulwark/bulwark.conf
fi
/bin/bulwarkd