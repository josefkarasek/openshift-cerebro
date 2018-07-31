FROM jboss/base-jdk:8

ENV CEREBRO_HOME=/opt/jboss/cerebro
ENV CEREBRO_VERSION=0.8.1
ARG CEREBRO_VERSION=0.8.1

USER root

ADD https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.zip /opt/jboss/

RUN unzip /opt/jboss/cerebro-${CEREBRO_VERSION}.zip \
    && mv /opt/jboss/cerebro-${CEREBRO_VERSION} ${CEREBRO_HOME} \
    && mkdir ${CEREBRO_HOME}/logs \
    && chown -R jboss:0 ${CEREBRO_HOME} \
    && chmod -R g+rw ${CEREBRO_HOME} \
    && rm -rf /opt/jboss/cerebro-${CEREBRO_VERSION}.zip

USER jboss

CMD [ "/opt/jboss/cerebro/bin/cerebro", "-Dhttp.address=0.0.0.0", "-Dconfig.file=/etc/cerebro/config/application.conf" ]
