FROM mesosphere/mesos:0.26.0-0.2.145.ubuntu1404

ADD vivid.list /etc/apt/sources.list.d/vivid.list
ADD vivid-preferences /etc/apt/preferences.d/vivid-preferences
ADD spark-1.6.0.tgz.sha /tmp/spark-1.6.0.tgz.sha

RUN apt-get update \
 && apt-get install --no-install-recommends -y curl openjdk-8-jre-headless openjdk-8-jdk \
 && apt-get install -y libatlas3-base libopenblas-base \
 && curl -sL http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0.tgz -o /tmp/spark-1.6.0.tgz \
 && (cd /tmp; sha512sum -c spark-1.6.0.tgz.sha) \
 && mkdir /tmp/spark-src \
 && tar -zx -C /tmp/spark-src --strip-components=1 -f /tmp/spark-1.6.0.tgz \
 && (cd /tmp/spark-src; ./dev/change-scala-version.sh 2.11; JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 ./make-distribution.sh -Phadoop-2.6 -Dscala-2.11 -DskipTests) \
 && mv /tmp/spark-src/dist /spark \
 && apt-get remove -y openjdk-8-jdk \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --auto libblas.so.3 \
 && update-alternatives --auto liblapack.so.3 

EXPOSE 4040
VOLUME /spark/conf

ENV PATH=/spark/bin:/bin:/usr/bin

ENTRYPOINT []
