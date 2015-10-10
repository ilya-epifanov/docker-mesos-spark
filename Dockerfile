FROM smartislav/mesos-slave-java8:0.23.0-1.0.ubuntu1404-1

ADD spark-1.5.1-bin-hadoop2.6.tgz.sha /tmp/spark-1.5.1-bin-hadoop2.6.tgz.sha
RUN mkdir /spark

RUN apt-get update \
 && apt-get install --no-install-recommends -y curl \
 && curl -sL http://apache-mirror.rbc.ru/pub/apache/spark/spark-1.5.1/spark-1.5.1-bin-hadoop2.6.tgz -o /tmp/spark-1.5.1-bin-hadoop2.6.tgz \
 && (cd /tmp; sha512sum -c spark-1.5.1-bin-hadoop2.6.tgz.sha) \
 && tar -zx -C /spark --strip-components=1 -f /tmp/spark-1.5.1-bin-hadoop2.6.tgz \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4040
VOLUME /spark/conf

ENV PATH=/spark/bin:/bin:/usr/bin

ENTRYPOINT []
