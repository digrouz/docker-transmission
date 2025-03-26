#!/usr/bin/env sh
mail -s "Transfer completed" root <<EOF
${TR_TORRENT_NAME} is finished.This is an automatic message from your friendly transmission-daemon (${TR_APP_VERSION}). Your files are in ${TR_TORRENT_DIR}.
EOF

# Prints a info message in the console
echo "[${TR_TIME_LOCALTIME}]-[${TR_TORRENT_NAME}] Download completed. Email notification sent."
