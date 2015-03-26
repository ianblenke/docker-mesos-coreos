FROM python
MAINTAINER Ian Blenke <ian@blenke.com>

RUN git clone https://github.com/mesosphere/mesos-cli /app
RUN pip install /app

ADD run.sh /run.sh
RUN chmod 755 /run.sh

# This is just an example, of course.
CMD /run.sh zk://172.17.42.1:2181/mesos resolve
