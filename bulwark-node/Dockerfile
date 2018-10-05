FROM ubuntu:16.04
LABEL maintainer="kewagi"
LABEL version="2.0.0.0"
LABEL name="Bulwark"

ENV BULWARK_VERSION 2.0.0.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ADD https://github.com/bulwark-crypto/Bulwark/releases/download/2.0.0/bulwark-node-2.0.0.0-linux64.tar.gz /
RUN tar xzf bulwark-node-2.0.0.0-linux64.tar.gz -C /bin/ \
  && rm bulwark-node-2.0.0.0-linux64.tar.gz \
  && adduser bulwark --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password > /dev/null
EXPOSE 52543
COPY entrypoint.sh /bin/
USER bulwark
RUN mkdir /home/bulwark/.bulwark && chown -R bulwark:bulwark /home/bulwark/.bulwark
WORKDIR /home/bulwark
VOLUME [ "/home/bulwark/.bulwark" ]
ENTRYPOINT ["/bin/entrypoint.sh"]