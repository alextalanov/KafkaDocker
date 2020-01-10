#!/bin/sh

while [[ $1 ]]; do
case $1 in
     --id)
          shift
          ID=$1
          shift
          ;;
     --config)
          shift
          CONFIG=$1
          shift
          ;;
     *)
          echo "'$1' arg is not supported"
          exit 1
          ;;
esac
done

if [[ $CONFIG ]]; then
     HOSTNAME=$(hostname -i)
     if [[ $ID ]]; then
          create-config.py "$CONFIG" "$HOSTNAME" "$ID"
          CONFIG_PATH=$KAFKA_CONFIG/server-$ID.properties
     else
          create-config.py "$CONFIG" "$HOSTNAME"
          CONFIG_PATH=$KAFKA_CONFIG/server.properties
     fi
fi

/bin/bash -c "kafka-server-start.sh $CONFIG_PATH"
