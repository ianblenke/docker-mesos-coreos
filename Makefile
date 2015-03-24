build:
	docker build -t ianblenke/mesos-master mesos-master/
	docker build -t ianblenke/mesos-slave mesos-slave/
	docker build -t ianblenke/mesos-marathon mesos-marathon/

install:
	fleetctl list-machines -fields=ip -no-legend | while read ip ; do scp zookeeper.cloud-init  $ip:/tmp; ssh -n $ip sudo coreos-cloudinit -from-file=/tmp/zookeeper.cloud-init ; done

