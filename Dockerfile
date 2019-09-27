FROM ubuntu as builder

ENV CHECKSUM 0a0497d6a8e5f3f48e10db8f89875286d6aa3388f171f828cf5d426cf305f16f
ENV VERSION 3.9.1
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

