# docker-alp-transmission
Installs Transmission into an Alpine container

![transmissionbt](https://upload.wikimedia.org/wikipedia/commons/archive/6/6d/20080126162557%21Transmission_icon.png)

## Description

Transmission is a cross-platform BitTorrent client that is:
- Open Source.
- Easy.
- Lean.
- Native.
- Powerful.

https://www.transmissionbt.com/

## Usage
    docker create --name=transmission  \
      -v <path to config>:/config  \
      -v <path to downloads>:/downloads   \
      -v <path to watch>:/watch  \
      -v /etc/localtime:/etc/localtime:ro   \
      -p 9091:9091  \
      -p 9092:9092  \
      -p 9092:9092/udp  digrouz/docker-alp-transmission



