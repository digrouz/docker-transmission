#!/usr/bin/env bash

. /etc/profile
. /usr/local/bin/docker-entrypoint-functions.sh

MYUSER="${APPUSER}"
MYGID="${APPGID}"
MYUID="${APPUID}"

NOTIFICATION_ENABLED=$(jq -r '.["script-torrent-done-enabled"]' /config/settings.json)
NOTIFICATION_SCRIPT=$(jq -r '.["script-torrent-done-filename"]' /config/settings.json)

if [ $NOTIFICATION_ENABLED == false ]; then
  DockLog "Enabling Notifications"
  jq '."script-torrent-done-enabled" = true' /config/settings.json | sponge /config/settings.json
fi
if [ $NOTIFICATION_SCRIPT != "/usr/local/bin/transmission-mail-notification.sh" ]; then
  DockLog "Setting notification script to /usr/local/bin/transmission-mail-notification.sh"
  jq '."script-torrent-done-filename" = "/usr/local/bin/transmission-mail-notification.sh"' /config/settings.json | sponge /config/settings.json
fi
