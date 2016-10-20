FROM ubuntu

RUN apt-get update

RUN mkdir -p /usr/java

COPY jdk1.8.0_112 /usr/java/jdk1.8.0_112

ENV JAVA_HOME=/usr/java/jdk1.8.0_112

ENV PATH=$JAVA_HOME/bin:$PATH

