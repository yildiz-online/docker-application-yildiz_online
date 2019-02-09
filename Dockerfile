p
FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
ARG BITBUCKET_USER
ARG BITBUCKET_TOKEN
WORKDIR /app
RUN git clone --branch develop https://$BITBUCKET_USER:$BITBUCKET_TOKEN@bitbucket.org/yildiz-online-team/game-server.git
RUN cd game-server

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
