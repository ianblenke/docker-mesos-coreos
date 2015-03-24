## docker-mesos-coreos

Reliably auto-deploy mesos on CoreOS with a Deis PaaS.

That's the idea behind this project at the moment anyway.

The docker autobuild and CoreOS fleet units were inspired by the Rancher blog article [Running a Mesos cluster on RancherOS](http://rancher.com/running-a-mesos-cluster-on-rancheros).

The [mesos.cloud-init](./mesos.cloud-init) included in this project is assumed to be run on every machine in the fleet.
This cloud-init assumes every machine runs a zookeeper, mesos master, slave, and marathon.
This understandably does not scale.

Rather than fight with haproxy immediately, and being that I'm primarily familiar with and most interested in running Deis on CoreOS,
a deis-publisher approach is used to proxy requests to `mesos.{domain}` and `marathon.{domain}` using deis-router.

Ongoing development of this project is to be able to deploy [kubernetes-mesos](https://github.com/mesosphere/kubernetes-mesos) and [a mesos based jenkins ci like ebay](http://www.ebaytechblog.com/2014/05/12/delivering-ebays-ci-solution-with-apache-mesos-part-ii/).

# Mesos configuration

The best source of [Mesos configuration documentation](http://mesos.apache.org/documentation/latest/configuration/) can be found on the Mesos website.

# Marathon

In the near future, integration of HAProxy with [Qubit Product's Bamboo](https://github.com/QubitProducts/bamboo/) or [haproxy-marathon-bridge](https://github.com/mesosphere/marathon/blob/master/bin/haproxy-marathon-bridge) instead of deis-router is planned.

The goal being [mesos service-discovery](https://mesosphere.com/docs/getting-started/service-discovery) of mesos hosted resources.

# Installing

Step 1: Install zookeeper.cloud-init on all machines in the fleet.

```console
fleetctl list-machines -fields=ip -no-legend | while read ip ; do \
  scp zookeeper.cloud-init $ip:/tmp; \
  ssh -n $ip sudo coreos-cloudinit -from-file=/tmp/zookeeper.cloud-init ; \
done
```

Step 2: Install mesos.cloud-init on all machines in the fleet.

```console
fleetctl list-machines -fields=ip -no-legend | while read ip ; do \
  scp mesos.cloud-init $ip:/tmp; \
  ssh -n $ip sudo coreos-cloudinit -from-file=/tmp/mesos.cloud-init ; \
done
```

Note: These will eventually be pulled into one unified cloud-init, this is merely convenience from having been borrowed from [github.com/ianblenke/coreos-vagrant-kitchen-sink](https://github.com/ianblenke/coreos-vagrant-kitchen-sink/blob/master/cloud-init/)

You should now be able to visit `http://mesos.{domain}` and `http://marathon.{domain}`, where `{domain}` is your deis wildcard domain name.

