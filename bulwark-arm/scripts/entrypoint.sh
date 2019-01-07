#!/bin/sh

if [ ! -f ~/.bulwark/bulwark.conf ]; then
  touch ~/.bulwark/bulwark.conf
fi

if ! grep rpcpassword ~/.bulwark/bulwark.conf; then
  RPCUSER="bulwarkrpc"
  RPCPASSWORD=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
  touch ~/.bulwark/bulwark.conf
  { echo "rpcuser=${RPCUSER}"; echo "rpcpassword=${RPCPASSWORD}"; echo "printtoconsole=1"; } >> ~/.bulwark/bulwark.conf
fi

exec /usr/local/bin/bulwarkd "$@"