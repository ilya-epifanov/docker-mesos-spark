FROM mesosphere/mesos:0.25.0-0.2.70.ubuntu1404

ADD vivid.list /etc/apt/sources.list.d/vivid.list
ADD vivid-preferences /etc/apt/preferences.d/vivid-preferences
ADD spark-1.5.1-bin-hadoop2.6.tgz.sha /tmp/spark-1.5.1-bin-hadoop2.6.tgz.sha
RUN mkdir /spark

RUN apt-get update \
 && apt-get install --no-install-recommends -y curl openjdk-8-jre-headless \
 && apt-get install -y libatlas3-base libopenblas-base \
 && curl -sL http://apache-mirror.rbc.ru/pub/apache/spark/spark-1.5.1/spark-1.5.1-bin-hadoop2.6.tgz -o /tmp/spark-1.5.1-bin-hadoop2.6.tgz \
 && (cd /tmp; sha512sum -c spark-1.5.1-bin-hadoop2.6.tgz.sha) \
 && tar -zx -C /spark --strip-components=1 -f /tmp/spark-1.5.1-bin-hadoop2.6.tgz \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4040
VOLUME /spark/conf

ENV PATH=/spark/bin:/bin:/usr/bin

ENTRYPOINT []
