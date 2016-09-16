#!/bin/sh
set -e
local MYUSER="mytransmission"
local MYGID="10003"
local MYUID="10003"

#Managing group
if [ -n "${DOCKGID}" ]; then
  MYGID="${DOCKGID}"
fi
if ! /bin/grep -q "${MYUSER}" /etc/group; then
  /usr/sbin/addgroup -S -g "${MYGID}" "${MYUSER}"
fi

#Managing user
if [ -n "${DOCKUID}" ]; then
  MYUID="${DOCKUID}"
fi
if ! /bin/grep -q "${MYUSER}" /etc/passwd; then
  /usr/sbin/adduser -S -D -H -G "${MYUSER}" -u "${MYUID}" "${MYUSER}"
fi

if [ "$1" = 'transmission' ]; then
    if [ -d /config ]; then
      chown -R "${MYUSER}":"${MYUSER}" /config
      chmod 0775 /config
    fi
    exec /sbin/su-exec "${MYUSER}" "/usr/bin/transmission-daemon --foreground --config-dir /config -c /watch -w /downloads -p 9091  -P 9092 --log-error"
fi

exec "$@"
