# teamspeak3 docker image

```docker run -it -p 9987:9987/udp -p 10011:10011 -p 30033:30033 -v <path-to-sqlitedb>:/teamspeak/ts3server.sqlitedb -v <path-to-logs>:/teamspeak/logs -v <path-to-files>:/teamspeak/files jpodeszwik/teamspeak```
