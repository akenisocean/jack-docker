#!/bin/bash
set -e

# Files created by Elasticsearch should always be group writable too
umask 002

/usr/share/elasticsearch/bin/elasticsearch-users useradd $ES_USER -p $ES_PASSWORD -r superuser || true

# RUN_MODE  cluster
if [ "${RUN_MODE}"x != "cluster"x ]; then
    rm -rf /usr/share/elasticsearch/config/elastic-certificates.p12
fi

run_as_other_user_if_needed() {
  if [[ "$(id -u)" == "0" ]]; then
    # If running as root, drop to specified UID and run command
    exec chroot --userspec=1000 / "${@}"
  else
    # Either we are running in Openshift with random uid and are a member of the root group
    # or with a custom --user
    exec "${@}"
  fi
}

run_as_other_user_if_needed /usr/share/elasticsearch/bin/elasticsearch