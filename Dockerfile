FROM ubuntu as builder

ENV CHECKSUM 92f8a4eb71d4cd6b69bedc4cc78db063eaa928446c9ed2c77a75fd617d7b25dd
ENV VERSION 3.11.0
ENV FILE teamspeak3-server_linux_amd64-$VERSION.tar.bz2

RUN apt update -y && \
    apt install -y bzip2

ADD https://files.teamspeak-services.com/releases/server/$VERSION/$FILE .

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

