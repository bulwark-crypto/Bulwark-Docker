FROM ubuntu:16.04
LABEL maintainer="kewagi <kewagi@bulwarkcrypto.com>"
LABEL version="2.0.0.0"
LABEL name="Bulwark"

ENV BULWARK_VERSION 2.0.0.0
SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

ADD https://github.com/bulwark-crypto/Bulwark/releases/download/2.0.0/bulwark-node-2.0.0.0-linux64.tar.gz /
COPY ./scripts/entrypoint.sh /usr/local/bin/

RUN apt-get update \
  && apt-get install --no-install-recommends -y nano=2.5.3-2ubuntu2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && tar xzf bulwark-node-2.0.0.0-linux64.tar.gz -C /usr/local/bin/ \
  && rm bulwark-node-2.0.0.0-linux64.tar.gz \
  && adduser bulwark --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password > /dev/null \
  && mkdir /home/bulwark/.bulwark && chown -R bulwark:bulwark /home/bulwark/.bulwark

USER bulwark
VOLUME [ "/home/bulwark/.bulwark" ]
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
EXPOSE 52543