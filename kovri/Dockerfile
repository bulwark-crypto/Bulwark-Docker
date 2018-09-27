FROM ubuntu:16.04
LABEL maintainer="kewagi"
LABEL version="0.1.0"
LABEL name="Kovri I2P"
ADD https://github.com/kewagi/kovri/releases/download/v0.1.0-alpha/kovri-0.1.0-alpha.tar.gz kovri.tar.gz
ADD https://github.com/kewagi/kovri/releases/download/v0.1.0-alpha/kovri-conf.tar.gz kovri-conf.tar.gz
RUN apt-get update \
  && apt-get -qq --no-install-recommends install \
  curl \
  doxygen=1.8.11-1 \
  graphviz=2.38.0-12ubuntu2.1 \
  libboost-all-dev=1.58.0.1ubuntu1 \
  libssl-dev=1.0.2g-1ubuntu4.13 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN adduser kovri --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password \
  && mkdir /home/kovri/.kovri \
  && tar xzf kovri.tar.gz --strip=1 -C /bin \
  && tar xzf kovri-conf.tar.gz -C /home/kovri/.kovri/ \
  && echo "[Bulwark]" > /home/kovri/.kovri/config/tunnels.conf \
  && echo "type = server" >> /home/kovri/.kovri/config/tunnels.conf \
  && echo "address = bulwark-i2p" >> /home/kovri/.kovri/config/tunnels.conf \
  && echo "port = 54525" >> /home/kovri/.kovri/config/tunnels.conf \
  && echo "in_port = 52543" >> /home/kovri/.kovri/config/tunnels.conf \
  && echo "keys = bulwarkd.dat" >> /home/kovri/.kovri/config/tunnels.conf \
  && chown -R kovri:kovri /home/kovri
VOLUME /home/kovri/.kovri
USER kovri
ENTRYPOINT ["/bin/kovri"] 
EXPOSE 9111-30777






