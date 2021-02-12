# FROM maven:3.6.3-jdk-8-slim as builder
FROM ubuntu:18.04 as builder

ARG SERVICE_NAME
ARG GOOGLE_CLOUD_PROJECT

RUN apt update && \
    apt install -y openjdk-8-jdk && \
    apt install -y maven && \
    apt install -y wget && \
    apt install -y openjfx=8u161-b12-1ubuntu2 libopenjfx-jni=8u161-b12-1ubuntu2 libopenjfx-java=8u161-b12-1ubuntu2 && \
    apt-mark hold openjfx libopenjfx-jni libopenjfx-java

COPY . /usr/src/

WORKDIR /usr/src/

RUN mvn clean package

RUN mkdir -p /opt/cprof
RUN wget -q -O- https://storage.googleapis.com/cloud-profiler/java/latest/profiler_java_agent.tar.gz | tar xzv -C /opt/cprof

#FROM openjdk:8-jdk-slim
#RUN apt update && \
#    apt install -y openjfx=8u161-b12-1ubuntu2 libopenjfx-jni=8u161-b12-1ubuntu2 libopenjfx-java=8u161-b12-1ubuntu2 && \
#    apt-mark hold openjfx libopenjfx-jni libopenjfx-java
#COPY --from=builder /usr/src/target/java-spring-boot-1.0.0.jar /

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -agentpath:/opt/cprof/profiler_java_agent.so=-cprof_service=${SERVICE_NAME},-cprof_service_version=1.0.0,-logtostderr,-cprof_project_id=${GOOGLE_CLOUD_PROJECT} -jar target/java-spring-boot-1.0.0.jar"]
