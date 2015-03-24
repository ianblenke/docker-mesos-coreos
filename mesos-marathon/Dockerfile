FROM ubuntu:14.04
MAINTAINER Ian Blenke <ian@blenke.com>

RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mesos
RUN service zookeeper stop
RUN apt-get -y remove --purge zookeeper
RUN echo manual > /etc/init/mesos-master.override

ADD http://downloads.mesosphere.com/marathon/v0.7.5/marathon-0.7.5.tgz /tmp/marathon-0.7.5.tgz
RUN cd /opt/ && tar xvf /tmp/marathon-0.7.5.tgz && mv marathon-0.7.5 marathon

EXPOSE 15050

CMD ["/opt/marathon/bin/start","--master","zk://172.17.42.1:2181/mesos","--zk","zk://172.17.42.1:2181"]
