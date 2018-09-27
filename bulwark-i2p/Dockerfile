FROM ubuntu:16.04
LABEL maintainer="kewagi"
LABEL version="1.3.1.0"
LABEL name="Bulwark via I2P"
ADD https://github.com/bulwark-crypto/Bulwark/releases/download/1.3.1/bulwark-1.3.1.0-linux64.tar.gz /bulwark-1.3.1.0-linux64.tar.gz
RUN tar xzf bulwark-1.3.1.0-linux64.tar.gz --strip=1 -C /bin/ \
  && rm bulwark-1.3.1.0-linux64.tar.gz 
RUN adduser bulwark --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password \
  && mkdir /home/bulwark/.bulwark \
  && touch /home/bulwark/.bulwark/bulwark.conf \
  && echo "proxy=kovri:4447" > /home/bulwark/.bulwark/bulwark.conf \
  && echo "server=1" >> /home/bulwark/.bulwark/bulwark.conf \
  && echo "listen=1" >> /home/bulwark/.bulwark/bulwark.conf \
  && echo "addnode=5koveienpnrrwz2jzzlw5xoxnzxdrqtn7jdkszzs73mvw4757dfq.b32.i2p" >> /home/bulwark/.bulwark/bulwark.conf \
  && echo "addnode=5tu24nzzp7fdu4saoxff7xso2o7c25npddohfupapf6m3ffeieha.b32.i2p" >> /home/bulwark/.bulwark/bulwark.conf \
  && echo "addnode=czra3immvcuuex3uxew2mh6einh7isxvpi6vinamcltlthj3xcuq.b32.i2p" >> /home/bulwark/.bulwark/bulwark.conf \
  && echo "addnode=o3pker3dqmrlacv6zwj42uhy2fc3dst5f3rddvp4qu3z3sbcq2ra.b32.i2p" >> /home/bulwark/.bulwark/bulwark.conf \
  && chown -R bulwark:bulwark /home/bulwark  
COPY --chown=bulwark:bulwark entrypoint.sh /bin/
VOLUME /home/bulwark/.bulwark
USER bulwark
ENTRYPOINT ["/bin/entrypoint.sh"]
EXPOSE 52543