FROM ubuntu

ENV CHECKSUM 19ccd8db5427758d972a864b70d4a1263ebb9628fcc42c3de75ba87de105d179
ENV VERSION 3.0.13.6
ENV FILE teamspeak3-server_linux_amd64-$VERSION.tar.bz2

RUN apt update -y && \
    apt install -y bzip2

ADD http://dl.4players.de/ts/releases/$VERSION/$FILE .

RUN echo "$CHECKSUM $FILE" | sha256sum -c -

RUN tar -xf $FILE && \
    mv teamspeak3-server_linux_amd64 /teamspeak

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

WORKDIR /teamspeak

CMD ["/teamspeak/ts3server_minimal_runscript.sh"]

