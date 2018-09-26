FROM ubuntu:16.04
LABEL maintainer="kewagi"
LABEL version="1.3.1.0"
LABEL name="Bulwark Node"
ADD https://github.com/bulwark-crypto/Bulwark/releases/download/1.3.1/bulwark-1.3.1.0-linux64.tar.gz /bulwark-1.3.1.0-linux64.tar.gz
RUN tar xzf bulwark-1.3.1.0-linux64.tar.gz --strip=1 -C /bin/ \
  && rm bulwark-1.3.1.0-linux64.tar.gz 
RUN adduser bulwark --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password \
  && mkdir /home/bulwark/data /home/bulwark/.bulwark \
  && touch /home/bulwark/.bulwark/bulwark.conf \
  && chown -R bulwark:bulwark /home/bulwark  
COPY --chown=bulwark:bulwark entrypoint.sh /bin/
VOLUME /home/bulwark/data
VOLUME /home/bulwark/.bulwark
USER bulwark
ENTRYPOINT ["/bin/entrypoint.sh"]
EXPOSE 52543