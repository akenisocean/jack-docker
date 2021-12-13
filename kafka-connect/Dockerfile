FROM confluentinc/cp-kafka-connect:5.3.3
MAINTAINER jichao@jkstack.com
USER root

ENV HOME=/opt \
    KAFKA_VERSION=5.3.5.0-dpltm-SNAPSHOT


RUN chmod 777 $HOME

WORKDIR /opt



COPY redshift-keytool.jar redshift-keytool.jar
RUN  java -jar redshift-keytool.jar -s && rm redshift-keytool.jar

COPY connect-runtime-5.3.5.0-dpltm-SNAPSHOT.jar connect-runtime-5.3.5.0-dpltm-SNAPSHOT.jar
COPY connect-api-5.3.5.0-dpltm-SNAPSHOT.jar connect-api-5.3.5.0-dpltm-SNAPSHOT.jar
COPY kafka-clients-5.3.5.0-dpltm-SNAPSHOT.jar kafka-clients-5.3.5.0-dpltm-SNAPSHOT.jar
COPY snappy-java-1.1.8.4.jar snappy-java-1.1.8.4.jar
COPY dp-runtime-0.18.0-SNAPSHOT.jar /usr/share/java/kafka/dp-runtime-0.18.0-SNAPSHOT.jar

RUN ls /usr/share/java/*/*connect-runtime* | xargs -i cp connect-runtime-${KAFKA_VERSION}.jar {} \
    && ls /usr/share/java/*/*connect-api* | xargs -i cp connect-api-${KAFKA_VERSION}.jar {} \
    && ls /usr/share/java/*/*kafka-clients* | xargs -i cp kafka-clients-${KAFKA_VERSION}.jar {} \
    && ls /usr/share/java/*/*snappy-java* | xargs -i cp snappy-java-1.1.8.4.jar {} \
    && rm -f /usr/share/java/confluent-rebalancer/guava-18.0.jar


