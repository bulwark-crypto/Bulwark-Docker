#!/bin/dash

if [ ! -f ~/.bulwark/bulwark.conf ]; then
  touch ~/.bulwark/bulwark.conf
fi

if ! grep rpcpassword ~/.bulwark/bulwark.conf; then
  RPCUSER="bulwarkrpc"
  RPCPASSWORD=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
  touch ~/.bulwark/bulwark.conf
  echo "rpcuser=${RPCUSER}" >> ~/.bulwark/bulwark.conf
  echo "rpcpassword=${RPCPASSWORD}" >> ~/.bulwark/bulwark.conf
  echo "printtoconsole=1" >> ~/.bulwark/bulwark.conf
fi

for ARG in "$@"; do
  echo "$ARG" >> ~/.bulwark/bulwark.conf
done

exec /bin/bulwarkd