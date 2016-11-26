FROM ubuntu:14.04

COPY ./spark-1.6.1-bin-hadoop2.6.tgz /prod/
RUN tar -xvzf /prod/spark-1.6.1-bin-hadoop2.6.tgz -C /prod/

COPY ./jdk-8u111-linux-x64.tar.gz /prod/
RUN tar -xvzf /prod/jdk-8u111-linux-x64.tar.gz -C /prod/

COPY ./sparkling-water-1.6.1 /prod/sparkling-water-1.6.1
COPY ./Anaconda3-4.0.0-Linux-x86_64.sh /prod/Anaconda3-4.0.0-Linux-x86_64.sh
RUN chmod 777 /prod/Anaconda3-4.0.0-Linux-x86_64.sh
RUN bash /prod/Anaconda3-4.0.0-Linux-x86_64.sh -b

RUN mkdir /prod/extra_jars
COPY ./aws-java-sdk-1.11.49.jar /prod/extra_jars/aws-java-sdk-1.11.49.jar
COPY ./hadoop-aws-2.7.3.jar /prod/extra_jars/hadoop-aws-2.7.3.jar

# Ugly hack required to keep Spark running in foreground in Docker
COPY ./start-master.sh /prod/spark-1.6.1-bin-hadoop2.6/sbin/start-master.sh
COPY ./start-slave.sh /prod/spark-1.6.1-bin-hadoop2.6/sbin/start-slave.sh

# Spark requires that JAVA_HOME is set
ENV JAVA_HOME /prod/jdk1.8.0_111


