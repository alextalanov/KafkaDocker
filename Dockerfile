FROM dockeralexandrtalan/java8

ARG HOME=/usr/local/lib
ARG APP=/usr/local/bin
ARG KAFKA_ARHIVE=kafka_2.12-2.4.0.tgz

WORKDIR $HOME

RUN apt install -y  python3
RUN wget --no-check-certificate https://www.dropbox.com/s/t63msia3pdn2lxq/kafka_2.12-2.4.0.tgz?dl=0 -O $KAFKA_ARHIVE
RUN tar -xvzf $KAFKA_ARHIVE
RUN rm -f $KAFKA_ARHIVE

ENV KAFKA_HOME=$HOME/kafka_2.12-2.4.0
ENV PATH=$PATH:$KAFKA_HOME/bin
ENV KAFKA_CONFIG=$KAFKA_HOME/config

COPY ./create-config.py $APP
COPY ./entrypoint.sh $APP

RUN chmod 777 $APP/create-config.py
RUN chmod 777 $APP/entrypoint.sh

CMD ["/bin/bash", "entrypoint.sh"]