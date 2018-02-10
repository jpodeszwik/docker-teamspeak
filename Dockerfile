FROM ubuntu

ENV CHECKSUM 460c771bf58c9a49b4be2c677652f21896b98a021d7fff286e59679b3f987a59
ENV VERSION 3.0.13.8
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

