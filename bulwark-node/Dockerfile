FROM ubuntu:16.04
LABEL maintainer="kewagi"
LABEL version="1.3.1.0"
LABEL name="Bulwark Node"
ADD https://github.com/bulwark-crypto/Bulwark/releases/download/1.3.1/bulwark-1.3.1.0-linux64.tar.gz /bulwark-1.3.1.0-linux64.tar.gz
RUN tar xzf bulwark-1.3.1.0-linux64.tar.gz --strip=1 -C /bin/ \
  && rm bulwark-1.3.1.0-linux64.tar.gz 
RUN adduser bulwark --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password \
  && mkdir /home/bulwark/.bulwark \
  && echo "rpcuser=bulwarkrpc" > /home/bulwark/.bulwark/bulwark.conf \
  && echo "rpcpassword=5JCox4D8rFPwet21D48UV5wkWVM9TktvmJbk3MuSyv8n" >> /home/bulwark/.bulwark/bulwark.conf \
  && chown -R bulwark:bulwark /home/bulwark
USER bulwark
ENTRYPOINT ["/bin/bulwarkd"]
EXPOSE 52543