#!/bin/sh

MYUSER="transmission"
MYGID="10003"
MYUID="10003"

ConfigureSsmtp () {
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

ConfigureUser () {
  # Managing user
  if [ -n "${DOCKUID}" ]; then
    MYUID="${DOCKUID}"
  fi
  # Managing group
  if [ -n "${DOCKGID}" ]; then
    MYGID="${DOCKGID}"
  fi
  local OLDHOME
  local OLDGID
  local OLDUID
  bin/grep -q "${MYUSER}" /etc/passwd
  if [ $? -eq 0 ]; then
    OLDUID=$(/usr/bin/id -u "${MYUSER}")
    OLDGID=$(/usr/bin/id -g "${MYUSER}")
    if [ "${DOCKUID}" != "${OLDUID}" ]; then
      OLDHOME=$(/bin/echo "~${MYUSER}")
      /usr/sbin/deluser "${MYUSER}"
      /usr/bin/logger "Deleted user ${MYUSER}"
    fi
    /bin/grep -q "${MYUSER}" /etc/group
    if [ $? -eq 0 ]; then
      local OLDGID=$(/usr/bin/id -g "${MYUSER}")
      if [ "${DOCKGID}" != "${OLDGID}" ]; then
        /usr/sbin/delgroup "${MYUSER}"
        /usr/bin/logger "Deleted group ${MYUSER}"
      fi
    fi
  fi
  /usr/sbin/addgroup -S -g "${MYGID}" "${MYUSER}"
  /usr/sbin/adduser -S -D -H -s /sbin/nologin -G "${MYUSER}" -h "${OLDHOME}" -u "${MYUID}" "${MYUSER}"
  if [ -n "${OLDUID}" ] && [ "${DOCKUID}" != "${OLDUID}" ]; then
    /usr/bin/find / -user "${OLDUID}" -exec /bin/chown ${MYUSER} {} \;
  fi
  if [ -n "${OLDGID}" ] && [ "${DOCKGID}" != "${OLDGID}" ]; then
    /usr/bin/find / -group "${OLDGID}" -exec /bin/chgrp ${MYUSER} {} \;
  fi
}

ConfigureUser
ConfigureSsmtp

if [ "$1" == 'transmission' ]; then
    if [ -d /config ]; then
      /bin/chown -R "${MYUSER}":"${MYUSER}" /config
      /bin/chmod 0775 /config
    fi
    if [ ! -f /config/transmission-mail-notification.sh ]; then
      cat << EOF2 > /config/transmission-mail-notification.sh
#!/bin/sh
/usr/bin/mail -s "Transfer completed" root <<EOF
\${TR_TORRENT_NAME} is finished.This is an automatic message from your friendly transmission-daemon (\${TR_APP_VERSION}). Your files are in \${TR_TORRENT_DIR}.
EOF
EOF2
      /bin/chown -R "${MYUSER}":"${MYUSER}" /config/transmission-mail-notification.sh
      /bin/chmod 0775 /config/transmission-mail-notification.sh
      /bin/sed -i "s|\ *\"script-torrent-done-enabled\":.*false,|\ \ \ \ \"script-torrent-done-enabled\":\ true,|i" /config/settings.json
      /bin/sed -i "s|\ *\"script-torrent-done-filename\":.*\"\",|\ \ \ \ \"script-torrent-done-filename\":\ \"/config/transmission-mail-notification.sh\",|i" /config/settings.json
    fi

    exec /sbin/su-exec "${MYUSER}" /usr/bin/transmission-daemon --foreground --config-dir /config -c /watch -w /downloads -p 9091  -P 9092 --log-error
fi

exec "$@"
