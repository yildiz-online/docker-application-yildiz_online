
FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone https://${BITBUCKET_USER}:pwGRfqyNLqCDYJKXzaF9@bitbucket.org/yildiz-online-team/game-server.git

FROM moussavdb/build-java as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=clone /app/game-server /app
RUN mvn install -s settings.xml

FROM moussavdb/runtime-java
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
EXPOSE 10501
COPY --from=build /app/target/game-server-assembly.jar /app
CMD ["java -jar game-server-assembly.jar"]
