FROM ubuntu:16.04
LABEL maintainer="kewagi"
LABEL version="2.0.0.0"
LABEL name="Bulwark"

ENV BULWARK_VERSION 2.0.0.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update \
  && apt-get -y install --no-install-recommends \ 
  software-properties-common=0.96.20.7 \
  && add-apt-repository -y ppa:bitcoin/bitcoin \
  && apt-get update \
  && apt-get -y install --no-install-recommends \
  autoconf=2.69-9 \
  automake=1:1.15-4ubuntu1 \
  bsdmainutils=9.0.6ubuntu3 \
  build-essential=12.1ubuntu2 \
  git=1:2.7.4-0ubuntu1.4 \
  libboost-all-dev=1.58.0.1ubuntu1 \
  libdb4.8-dev=4.8.30-xenial4 \ 
  libdb4.8++-dev=4.8.30-xenial4 \
  libevent-dev=2.0.21-stable-2ubuntu0.16.04.1 \
  libssl-dev=1.0.2g-1ubuntu4.13 \
  libtool=2.4.6-0.1 \
  miniupnpc=1.9.20140610-2ubuntu2.16.04.2 \
  pkg-config=0.29.1-0ubuntu1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && git clone https://github.com/bulwark-crypto/Bulwark.git
WORKDIR /Bulwark
RUN ./autogen.sh \
  && ./configure --disable-tests --with-gui=no \
  && make \
  && strip ./src/bulwarkd ./src/bulwark-cli \
  && mv ./src/bulwarkd ./src/bulwark-cli /bin
#RUN adduser bulwark --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password > /dev/null \
#  && chown -R bulwark:bulwark /home/bulwark
EXPOSE 52543
COPY entrypoint.sh /bin/
#USER bulwark
VOLUME [ "/root/.bulwark" ]
ENTRYPOINT ["/bin/entrypoint.sh"]