FROM ubuntu:14.04
MAINTAINER Ian Blenke <ian@blenke.com>

RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mesos
RUN service zookeeper stop
RUN apt-get -y remove --purge zookeeper
RUN echo manual > /etc/init/mesos-master.override

EXPOSE 5051

CMD ["mesos-slave", "--master=172.17.42.1:5050"]
