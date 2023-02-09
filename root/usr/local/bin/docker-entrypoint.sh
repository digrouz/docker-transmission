#!/usr/bin/env bash

. /etc/profile
. /usr/local/bin/docker-entrypoint-functions.sh

MYUSER="${APPUSER}"
MYGID="${APPGID}"
MYUID="${APPUID}"

AutoUpgrade
ConfigureUser

if [ "${1}" == 'transmission' ]; then
  if [ -d /config ]; then
    chown -R "${MYUSER}":"${MYUSER}" /config
    chmod 0775 /config
  fi

  RunDropletEntrypoint

  DockLog "Starting app: ${1}"
  exec su-exec "${MYUSER}" transmission-daemon --foreground --config-dir /config -c /watch -w /downloads -p 9091  -P 9092 --log-error
else
  DockLog "Starting command: ${1}"
  exec "$@"
fi

