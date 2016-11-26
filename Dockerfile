FROM ubuntu:14.04

COPY ./spark-1.6.1-bin-hadoop2.6.tgz /prod/
RUN tar -xvzf /prod/spark-1.6.1-bin-hadoop2.6.tgz -C /prod/

COPY ./jdk-8u111-linux-x64.tar.gz /prod/
RUN tar -xvzf /prod/jdk-8u111-linux-x64.tar.gz -C /prod/

# Ugly hack required to keep Spark running in foreground in Docker
COPY ./start-master.sh /prod/spark-1.6.1-bin-hadoop2.6/sbin/start-master.sh
COPY ./start-slave.sh /prod/spark-1.6.1-bin-hadoop2.6/sbin/start-slave.sh
#RUN echo 'tail -f /dev/null' >> /prod/spark-1.6.1-bin-hadoop2.6/sbin/start-slave.sh

# Spark requires that JAVA_HOME is set
ENV JAVA_HOME /prod/jdk1.8.0_111


