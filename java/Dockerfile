# FROM maven:3.6.3-jdk-8-slim as builder
FROM ubuntu:18.04 as builder

RUN apt update && \
    apt install -y openjdk-8-jdk && \
    apt install -y maven && \
    apt install -y openjfx=8u161-b12-1ubuntu2 libopenjfx-jni=8u161-b12-1ubuntu2 libopenjfx-java=8u161-b12-1ubuntu2 && \
    apt-mark hold openjfx libopenjfx-jni libopenjfx-java

COPY . /usr/src/

WORKDIR /usr/src/

RUN mvn clean package

#FROM openjdk:8-jdk-slim
#RUN apt update && \
#    apt install -y openjfx=8u161-b12-1ubuntu2 libopenjfx-jni=8u161-b12-1ubuntu2 libopenjfx-java=8u161-b12-1ubuntu2 && \
#    apt-mark hold openjfx libopenjfx-jni libopenjfx-java
#COPY --from=builder /usr/src/target/java-spring-boot-1.0.0.jar /

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "target/java-spring-boot-1.0.0.jar"]
