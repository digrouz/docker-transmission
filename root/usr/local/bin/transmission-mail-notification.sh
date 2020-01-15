#!/bin/bash
mail -s "Transfer completed" root <<EOF
${TR_TORRENT_NAME} is finished.This is an automatic message from your friendly transmission-daemon (${TR_APP_VERSION}). Your files are in ${TR_TORRENT_DIR}.
EOF
