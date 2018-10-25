FROM ubuntu:16.04
LABEL maintainer="kewagi"
LABEL version="2.1.0.0"
LABEL name="Bulwark"

ENV BULWARK_VERSION 2.0.0.0
SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

ADD bulwark-node-2.1.0.0-linux64.tar.gz /usr/local/bin
COPY entrypoint.sh /usr/local/bin/

RUN apt-get update \
  && apt-get install --no-install-recommends -y nano=2.5.3-2ubuntu2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && adduser bulwark --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password > /dev/null \
  && mkdir -p /home/bulwark/.bulwark/testnet4 && chown -R bulwark:bulwark /home/bulwark/.bulwark

USER bulwark
VOLUME [ "/home/bulwark/.bulwark" ]
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]