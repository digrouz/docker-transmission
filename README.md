[![auto-update](https://github.com/digrouz/docker-transmission/actions/workflows/auto-update.yml/badge.svg)](https://github.com/digrouz/docker-transmission/actions/workflows/auto-update.yml)
[![update-alpine](https://github.com/digrouz/docker-transmission/actions/workflows/update-alpine.yml/badge.svg)](https://github.com/digrouz/docker-transmission/actions/workflows/update-alpine.yml)
[![dockerhub](https://github.com/digrouz/docker-transmission/actions/workflows/dockerhub/badge.svg)](https://github.com/digrouz/docker-transmission/actions/workflows/dockerhub.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/digrouz/transmission)

# docker-transmission
Installs Transmission into an Alpine container. It supports mail notifications through `ssmtp`.

![transmissionbt](https://upload.wikimedia.org/wikipedia/commons/archive/6/6d/20080126162557%21Transmission_icon.png)

## Tag
Several tag are available:
* latest: see alpine
* alpine: [Dockerfile_alpine](https://github.com/digrouz/docker-transmission/blob/master/Dockerfile_alpine)


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
      -e DOCKUID=<UID default:10003> \
      -e DOCKGID=<GID default:10003> \
      -e DOCKMAIL=<mail address> \
      -e DOCKRELAY=<smtp relay> \
      -e DOCKMAILDOMAIN=<originating mail domain> \
      -p 9092:9092/udp  digrouz/docker-transmission

## Environment Variables

When you start the `transmission` image, you can adjust the configuration of the `transmission` instance by passing one or more environment variables on the `docker run` command line.

### `DOCKUID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `10003`.

### `DOCKGID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `10003`.

### `DOCKRELAY`

This variable is not mandatory and specifies the smtp relay that will be used to send email. Do not specify any if mail notifications are not required.

### `DOCKMAIL`

This variable is not mandatory and specifies the mail that has to be used to send email. Do not specify any if mail notifications are not required.

### `DOCKMAILDOMAIN`

This variable is not mandatory and specifies the address where the mail appears to come from for user authentication. Do not specify any if mail notifications are not required.

### `DOCKUPGRADE`

This variable is not mandatory and specifies if the container has to launch software update at startup or not. Valid values are `0` and `1`. It has default value `0`.

## Notes

* The docker entrypoint can upgrade operating system at each startup. To enable this feature, just add `-e DOCKUPGRADE=1` at container creation.

## Issues

If you encounter an issue please open a ticket at [github](https://github.com/digrouz/docker-transmission/issues)
