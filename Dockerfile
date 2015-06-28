FROM smartislav/mesos-slave-java8:0.22.1-1.0.ubuntu1404

ADD spark-1.4.0-bin-hadoop2.6.tgz.sha /tmp/spark-1.4.0-bin-hadoop2.6.tgz.sha
RUN mkdir /spark

RUN apt-get update \
 && apt-get install --no-install-recommends -y curl \
 && curl -sL http://d3kbcqa49mib13.cloudfront.net/spark-1.4.0-bin-hadoop2.6.tgz -o /tmp/spark-1.4.0-bin-hadoop2.6.tgz \
 && (cd /tmp; sha512sum -c spark-1.4.0-bin-hadoop2.6.tgz.sha) \
 && tar -zx -C /spark --strip-components=1 -f /tmp/spark-1.4.0-bin-hadoop2.6.tgz \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4040
VOLUME /spark/conf

ENTRYPOINT ["/spark/bin/spark-submit"]
