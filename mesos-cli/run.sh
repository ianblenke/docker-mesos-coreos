#!/bin/bash
mesos config master $1
shift
mesos $@
