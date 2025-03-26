[![auto-update](https://github.com/digrouz/docker-transmission/actions/workflows/auto-update.yml/badge.svg)](https://github.com/digrouz/docker-transmission/actions/workflows/auto-update.yml)
[![dockerhub](https://github.com/digrouz/docker-transmission/actions/workflows/dockerhub.yml/badge.svg)](https://github.com/digrouz/docker-transmission/actions/workflows/dockerhub.yml)
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
      -p 9091:9091  \
      -p 9092:9092  \
      -e UID=<UID default:12345> \
      -e GID=<GID default:12345> \
      -e AUTOUPGRADE=<0|1 default:0> \
      -e TZ=<timezone default:Europe/Brussels> \
      -e DOCKNOTIFTYPE=<notification type. telegram|mail> \
      -e DOCKMAIL=<mail address> \
      -e DOCKRELAY=<smtp relay> \
      -e DOCKMAILDOMAIN=<originating mail domain> \
      -e DOCKTELEGRAMBOTTOKEN=<Telegram bot token> \
      -e DOCKTELEGRAMCHATID=<Telegram chat id> \
      -p 9092:9092/udp  digrouz/transmission

## Environment Variables

When you start the `transmission` image, you can adjust the configuration of the `transmission` instance by passing one or more environment variables on the `docker run` command line.

### `UID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `12345`.

### `GID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `12345`.

### `AUTOUPGRADE`

This variable is not mandatory and specifies if the container has to launch software update at startup or not. Valid values are `0` and `1`. It has default value `0`.

### `TZ`

This variable is not mandatory and specifies the timezone to be configured within the container. It has default value `Europe/Brussels`.

### `DOCKRELAY`

This variable is not mandatory and specifies the smtp relay that will be used to send email. Do not specify any if mail notifications are not required.

### `DOCKMAIL`

This variable is not mandatory and specifies the mail that has to be used to send email. Do not specify any if mail notifications are not required.

### `DOCKMAILDOMAIN`

This variable is not mandatory and specifies the address where the mail appears to come from for user authentication. Do not specify any if mail notifications are not required.

### `DOCKNOTIFTYPE`

This variable is not mandatory and specifies which type of notifications with be sent by Transmission when a torrent is completed. Valid values are `mail` or `telegram`.

### `DOCKTELEGRAMBOTTOKEN`

This variable is not mandatory and specifices what Telegram Bot Token will be used to send notifications when a torrent is completed.

### `DOCKTELEGRAMCHATID`

This variable is not mandatory and specifices what Telegram Chat ID will be used to send notifications when a torrent is completed.

### `DOCKUPGRADE`

This variable is not mandatory and specifies if the container has to launch software update at startup or not. Valid values are `0` and `1`. It has default value `0`.

## Notes

* This container is built using [s6-overlay](https://github.com/just-containers/s6-overlay)
* The docker entrypoint can upgrade operating system at each startup. To enable this feature, just add `-e AUTOUPGRADE=1` at container creation.

## Issues

If you encounter an issue please open a ticket at [github](https://github.com/digrouz/docker-transmission/issues)
