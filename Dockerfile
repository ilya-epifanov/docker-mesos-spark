FROM mesosphere/mesos:0.26.0-0.2.145.ubuntu1404

ADD vivid.list /etc/apt/sources.list.d/vivid.list
ADD vivid-preferences /etc/apt/preferences.d/vivid-preferences
ADD spark-1.6.0-bin-hadoop2.6.tgz.sha /tmp/spark-1.6.0-bin-hadoop2.6.tgz.sha
RUN mkdir /spark

RUN apt-get update \
 && apt-get install --no-install-recommends -y curl openjdk-8-jre-headless \
 && apt-get install -y libatlas3-base libopenblas-base \
 && update-alternatives --config libblas.so \
 && update-alternatives --config libblas.so.3 \
 && update-alternatives --config liblapack.so \
 && update-alternatives --config liblapack.so.3 \
 && curl -sL http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz -o /tmp/spark-1.6.0-bin-hadoop2.6.tgz \
 && (cd /tmp; sha512sum -c spark-1.6.0-bin-hadoop2.6.tgz.sha) \
 && tar -zx -C /spark --strip-components=1 -f /tmp/spark-1.6.0-bin-hadoop2.6.tgz \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4040
VOLUME /spark/conf

ENV PATH=/spark/bin:/bin:/usr/bin

ENTRYPOINT []
