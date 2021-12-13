#!/usr/bin/env bash
#
# Copyright 2016 Confluent Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o nounset \
    -o errexit \
    -o verbose \
    -o xtrace
#CONTAINERID=$(cat /etc/hostname)
#export CONNECT_REST_ADVERTISED_HOST_NAME=$CONTAINERID

dub ensure CONNECT_REST_ADVERTISED_HOST_NAME
dub ensure CONNECT_BOOTSTRAP_SERVERS
dub ensure CONNECT_GROUP_ID
dub ensure CONNECT_CONFIG_STORAGE_TOPIC
dub ensure CONNECT_OFFSET_STORAGE_TOPIC
dub ensure CONNECT_STATUS_STORAGE_TOPIC
dub ensure CONNECT_KEY_CONVERTER
dub ensure CONNECT_VALUE_CONVERTER
dub ensure CONNECT_INTERNAL_KEY_CONVERTER
dub ensure CONNECT_INTERNAL_VALUE_CONVERTER
# This is required to avoid config bugs. You should set this to a value that is
# resolvable by all containers.


# Default to 8083, which matches the mesos-overrides. This is here in case we extend the containers to remove the mesos overrides.
if [ -z "$CONNECT_REST_PORT" ]; then
  export CONNECT_REST_PORT=8083
fi

# Fix for https://issues.apache.org/jira/browse/KAFKA-3988
if [[ $CONNECT_INTERNAL_KEY_CONVERTER == "org.apache.kafka.connect.json.JsonConverter" ]] || [[ $CONNECT_INTERNAL_VALUE_CONVERTER == "org.apache.kafka.connect.json.JsonConverter" ]]
then
  export CONNECT_INTERNAL_KEY_CONVERTER_SCHEMAS_ENABLE=false
  export CONNECT_INTERNAL_VALUE_CONVERTER_SCHEMAS_ENABLE=false
fi

if [[ $CONNECT_KEY_CONVERTER == "io.confluent.connect.avro.AvroConverter" ]]
then
  dub ensure CONNECT_KEY_CONVERTER_SCHEMA_REGISTRY_URL
fi

if [[ $CONNECT_VALUE_CONVERTER == "io.confluent.connect.avro.AvroConverter" ]]
then
  dub ensure CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL
fi

dub path /etc/"${COMPONENT}"/ writable

dub template "/etc/confluent/docker/${COMPONENT}.properties.template" "/etc/${COMPONENT}/${COMPONENT}.properties"

CONTAINERID=$(cat /etc/hostname)

echo "container id: $CONTAINERID"
sed -i "s|LOG_PREFIX|$CONTAINERID|g" /etc/kafka/connect-log4j.properties

LOG_LEVEL=${LOG_LEVEL:-}
if [ -z "$LOG_LEVEL" ]; then
   export LOG_LEVEL="INFO"
fi

DP_LOG_LEVEL=${DP_LOG_LEVEL:-}
if [ -z "$DP_LOG_LEVEL" ]; then
   export DP_LOG_LEVEL="INFO"
fi

LOG_ENCODING=${LOG_ENCODING:-}
if [ -z "$LOG_ENCODING" ]; then
   export LOG_ENCODING="UTF-8"
fi


CONSOLE_OUTPUT=${CONSOLE_OUTPUT:-}
if [ -z "$CONSOLE_OUTPUT" ]; then
   sed -i "s|CONSOLE_OUTPUT||g" /etc/kafka/connect-log4j.properties
else
   sed -i "s|CONSOLE_OUTPUT|, stdout|g" /etc/kafka/connect-log4j.properties
fi

sed -i "s|=LOG_LEVEL|=$LOG_LEVEL|g" /etc/kafka/connect-log4j.properties
sed -i "s|=DP_LOG_LEVEL|=$DP_LOG_LEVEL|g" /etc/kafka/connect-log4j.properties
sed -i "s|=LOG_ENCODING|=$LOG_ENCODING|g" /etc/kafka/connect-log4j.properties