#!/usr/bin/env bash

. /etc/profile
. /usr/local/bin/docker-entrypoint-functions.sh

# Customizing sstmp
if [ -f /etc/ssmtp/ssmtp.conf ];then
  # Configure relay
  if [ -n "${DOCKRELAY}" ]; then
    sed -i "s|mailhub=mail|mailhub=${DOCKRELAY}|i" /etc/ssmtp/ssmtp.conf
  fi
  # Configure root
  if [ -n "${DOCKMAIL}" ]; then
    sed -i "s|root=postmaster|root=${DOCKMAIL}|i" /etc/ssmtp/ssmtp.conf
  fi
  # Configure domain
  if [ -n "${DOCKMAILDOMAIN}" ]; then
    sed -i "s|#rewriteDomain=.*|rewriteDomain=${DOCKMAILDOMAIN}|i" /etc/ssmtp/ssmtp.conf
  fi
fi

