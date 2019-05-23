FROM resin/rpi-raspbian:stretch
LABEL maintainer="cryptohunter <thecryptohunter@protonmail.com>"
LABEL version="2.2.0.0"
LABEL name="Bulwark"

ENV BULWARK_VERSION 2.2.0.0
SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

ADD https://github.com/bulwark-crypto/Bulwark/releases/download/2.2.0/bulwark-node-2.2.0.0-linuxARM.tar.gz /
ADD https://raw.githubusercontent.com/bulwark-crypto/Bulwark-Docker/master/bulwark-arm/scripts/entrypoint.sh /usr/local/bin/

RUN apt-get update \
  && apt-get install --no-install-recommends -y nano=2.7.4-1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && tar xzf bulwark-node-2.2.0.0-linuxARM.tar.gz -C /usr/local/bin/ \
  && rm bulwark-node-2.2.0.0-linuxARM.tar.gz \
  && adduser bulwark --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password > /dev/null \
  && mkdir /home/bulwark/.bulwark && chown -R bulwark:bulwark /home/bulwark/.bulwark \
  && chmod a+x /usr/local/bin/entrypoint.sh \
  && chown bulwark:bulwark /usr/local/bin/entrypoint.sh

USER bulwark
VOLUME [ "/home/bulwark/.bulwark" ]
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
EXPOSE 52543