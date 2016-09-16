#!/bin/sh
set -e
local MYUSER="mytransmission"
local MYGID="10003"
local MYUID="10003"

# Managing group
if [ -n "${DOCKGID}" ]; then
  MYGID="${DOCKGID}"
fi
if ! /bin/grep -q "${MYUSER}" /etc/group; then
  /usr/sbin/addgroup -S -g "${MYGID}" "${MYUSER}"
fi

# Managing user
if [ -n "${DOCKUID}" ]; then
  MYUID="${DOCKUID}"
fi
if ! /bin/grep -q "${MYUSER}" /etc/passwd; then
  /usr/sbin/adduser -S -D -H -G "${MYUSER}" -u "${MYUID}" "${MYUSER}"
fi

# Customizing sstmp 
if [ -f /etc/ssmtp/ssmtp.conf ];then 
  # Configure relay
  if [ -n "${DOCKRELAY}" ]; then
    /bin/sed -i "s|mailhub=mail|mailhub=${DOCKRELAY}|i" /etc/ssmtp/ssmtp.conf
  fi 
  # Configure root 
  if [ -n "${DOCKMAIL}" ]; then
    /bin/sed -i "s|root=postmaster|root=${DOCKMAIL}|i" /etc/ssmtp/ssmtp.conf
  fi
  # Configure domain
  if [ -n "${DOCKMAILDOMAIN}" ]; then
    /bin/sed -i "s|#rewriteDomain=.*|rewriteDomain=${DOCKMAILDOMAIN}|i" /etc/ssmtp/ssmtp.conf
  fi
fi

if [ "$1" = 'transmission' ]; then
    if [ -d /config ]; then
      chown -R "${MYUSER}":"${MYUSER}" /config
      chmod 0775 /config
    fi
    exec /sbin/su-exec "${MYUSER}" /usr/bin/transmission-daemon --foreground --config-dir /config -c /watch -w /downloads -p 9091  -P 9092 --log-error
fi

exec "$@"
