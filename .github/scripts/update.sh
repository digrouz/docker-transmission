#!/usr/bin/env bash

TRANSMISSION_URL="https://api.github.com/repos/transmission/transmission/tags"

LAST_VERSION=$(curl -SsL ${TRANSMISSION_URL} | jq .[0].name -r )

sed -i -e "s|TRANSMISSION_VERSION='.*'|TRANSMISSION_VERSION='${LAST_VERSION}'|" Dockerfile*

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update to version: ${LAST_VERSION}"
  git push
fi
