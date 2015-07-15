# docker-mesos-spark

Spark 1.4.1 built with Hadoop 2.6, also containing Mesos 0.22 client libraries

You should run this with host networking due to limitations in mesos client.
In case your host is multihomed, don't forget to set the following environment variables:

```
LIBPROCESS_IP= # addressable IP of the host for mesos communications
SPARK_LOCAL_IP= # the same for spark driver
```
