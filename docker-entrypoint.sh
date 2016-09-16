#!/bin/sh
set -e
local MYUSER="transmission"
local MYGID="10003"
local MYUID="10003"

function ConfigureSsmtp {
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
}

function ConfigureGroup {
  # Managing group
  if [ -n "${DOCKGID}" ]; then
    MYGID="${DOCKGID}"
  fi
  local OLDGID=$(/usr/bin/id -g "${MYUSER}")
  if [ $? -eq 0 && "${DOCKGID}" != "${OLDGID}" ]; then
    /usr/sbin/delgroup "${MYUSER}"
    /usr/bin/logger "Deleted group ${MYUSER}"
  fi
  /usr/sbin/addgroup -S -g "${MYGID}" "${MYUSER}"
  if [ -n "${OLDGID}" && "${DOCKGID}" != "${OLDGID}" ]; then
    /usr/bin/find / -group "${OLDGID}" -exec /bin/chgrp ${MYUSER} {} \;
  fi

}

function ConfigureUser {
  ConfigureGroup
  # Managing user
  if [ -n "${DOCKUID}" ]; then
    MYUID="${DOCKUID}"
  fi
  local OLDHOME
  local OLDUID=$(/usr/bin/id -u "${MYUSER}")
  if [ $? -eq 0 && "${DOCKUID}" != "${OLDUID}" ]; then
    OLDHOME=$(echo "~${MYUSER}") 
    /usr/sbin/deluser "${MYUSER}"
    /usr/bin/logger "Deleted user ${MYUSER}"
  fi  
  /usr/sbin/adduser -S -D -H -s /sbin/nologin -G "${MYUSER}" -h "${OLDHOME}" -u "${MYUID}" "${MYUSER}"
  if [ -n "${OLDUID}" && "${DOCKUID}" != "${OLDUID}" ]; then
    /usr/bin/find / -user "${OLDUID}" -exec /bin/chown ${MYUSER} {} \;
  fi
}

ConfigureUser
ConfigureSsmtp

if [ "$1" == 'transmission' ]; then
    if [ -d /config ]; then
      chown -R "${MYUSER}":"${MYUSER}" /config
      chmod 0775 /config
    fi
    exec /sbin/su-exec "${MYUSER}" /usr/bin/transmission-daemon --foreground --config-dir /config -c /watch -w /downloads -p 9091  -P 9092 --log-error
fi

exec "$@"
