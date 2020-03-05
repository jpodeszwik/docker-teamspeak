FROM ubuntu as builder

ENV CHECKSUM 18c63ed4a3dc7422e677cbbc335e8cbcbb27acd569e9f2e1ce86e09642c81aa2
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

