#!/usr/bin/env bash

. /etc/profile
. /usr/local/bin/docker-entrypoint-functions.sh

MYUSER="${APPUSER}"
MYGID="${APPGID}"
MYUID="${APPUID}"

BLOCKLIST_ENABLED=$(jq -r '.["blocklist-enabled"]' /config/settings.json)
BLOCKLIST_URL=$(jq -r '.["blocklist-url"]' /config/settings.json | sed 's/\&amp;/\&/g')

if [ $BLOCKLIST_ENABLED == true ]; then
  DockLog "Updating blocklists"
  mkdir /config/blocklists-tmp
  wget -q "${BLOCKLIST_URL}" -O /config/blocklists-tmp/blocklist.gz
  if [ $? == 0 ]; then
    cd /config/blocklists-tmp
    gunzip blocklist.gz
    if [ $? == 0 ]; then
      chmod go+r *
      rm -rf /config/blocklists/* /config/blocklists-tmp/blocklist.gz
      mv /config/blocklists-tmp/* /config/blocklists
      rm -rf /config/blocklists-tmp
    fi
  fi
fi
