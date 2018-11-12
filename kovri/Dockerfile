FROM ubuntu:16.04
LABEL maintainer="kewagi <kewagi@bulwarkcrypto.com>"
LABEL version="0.1.0"
LABEL name="Kovri I2P"
ADD https://github.com/kewagi/kovri/releases/download/v0.1.0-alpha/kovri-0.1.0-alpha.tar.gz kovri.tar.gz
ADD https://github.com/kewagi/kovri/releases/download/v0.1.0-alpha/kovri-conf.tar.gz kovri-conf.tar.gz
RUN apt-get update \
  && apt-get -qq --no-install-recommends install \
  doxygen=1.8.11-1 \
  graphviz=2.38.0-12ubuntu2.1 \
  libboost-all-dev=1.58.0.1ubuntu1 \
  libssl-dev=1.0.2g-1ubuntu4.13 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN adduser --uid 1000 kovri --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password \
  && mkdir /home/kovri/.kovri \
  && mkdir /home/kovri/share \
  && tar xzf kovri.tar.gz --strip=1 -C /usr/local/bin/ \
  && tar xzf kovri-conf.tar.gz -C /home/kovri/.kovri/ \
  && echo "[Bulwark]" > /home/kovri/.kovri/config/tunnels.conf \
  && echo "type = server" >> /home/kovri/.kovri/config/tunnels.conf \
  && echo "address = bulwark" >> /home/kovri/.kovri/config/tunnels.conf \
  && echo "port = 52543" >> /home/kovri/.kovri/config/tunnels.conf \
  && echo "in_port = 52543" >> /home/kovri/.kovri/config/tunnels.conf \
  && echo "keys = bulwarkd.dat" >> /home/kovri/.kovri/config/tunnels.conf \
  && chown -R kovri:kovri /home/kovri
COPY ./scripts/entrypoint.sh /usr/local/bin/
USER kovri
VOLUME /home/kovri/.kovri
ENTRYPOINT [ "sh", "-c", "/usr/local/bin/entrypoint.sh" ]
EXPOSE 4447






