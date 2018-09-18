FROM ubuntu as builder

ENV CHECKSUM 7d6ec8e97d4a9e9913a7e01f2e7f5f9fddfdc41b11e668d013a0f4b574d1918b
ENV VERSION 3.4.0
ENV FILE teamspeak3-server_linux_amd64-$VERSION.tar.bz2

RUN apt update -y && \
    apt install -y bzip2

ADD http://dl.4players.de/ts/releases/$VERSION/$FILE .

RUN echo "$CHECKSUM $FILE" | sha256sum -c -

RUN tar -xf $FILE
RUN mv teamspeak3-server_linux_amd64 /teamspeak

from ubuntu

COPY --from=builder /teamspeak /teamspeak

RUN apt update -y && apt install ca-certificates -y

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

WORKDIR /teamspeak

CMD ["/teamspeak/ts3server_minimal_runscript.sh"]

