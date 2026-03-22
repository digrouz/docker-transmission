# docker-transmission

[![auto-update](https://github.com/digrouz/docker-transmission/actions/workflows/auto-update.yml/badge.svg)](https://github.com/digrouz/docker-transmission/actions/workflows/auto-update.yml)
[![dockerhub](https://github.com/digrouz/docker-transmission/actions/workflows/dockerhub.yml/badge.svg)](https://github.com/digrouz/docker-transmission/actions/workflows/dockerhub.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/digrouz/transmission)

Installs Transmission into an Alpine container. It supports mail notifications through `ssmtp`.

![transmissionbt](https://upload.wikimedia.org/wikipedia/commons/archive/6/6d/20080126162557%21Transmission_icon.png)

## Tag

Several tag are available:

* latest: see alpine
* alpine: [Dockerfile_alpine](https://github.com/digrouz/docker-transmission/blob/master/Dockerfile_alpine)

## Description

Transmission is a cross-platform BitTorrent client that is:

* Open Source.
* Easy.
* Lean.
* Native.
* Powerful.

[Official Website](https://www.transmissionbt.com/)

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
      -e DOCKUMASK=<transmission umask default:002> \
      -e DOCKBLOCKLISTENABLED=<transmission blocklist:true> \
      -e DOCKBLOCKLISTURL=<transmission blocklist URL> \
      -e DOCKMAILDOMAIN=<originating mail domain> \
      -e DOCKTELEGRAMBOTTOKEN=<Telegram bot token> \
      -e DOCKTELEGRAMCHATID=<Telegram chat id> \
      -e DOCKRPCENABLED=<transmission rpc enabled:true> \
      -e DOCKRPCPORT=<transmission rpc port:9092> \
      -e DOCKRPCBINDADDRESS=<transmission rpc bind address:0.0.0.0> \
      -e DOCKRPCAUTHENTICATIONREQUIRED=<transmission rpc authentication required:true> \
      -e DOCKRPCUSERNAME=<transmission rpc username> \
      -e DOCKRPCPASSWORD=<transmission rpc password> \
      -e DOCKRPCWHITELISTENABLED=<transmission rpc whitelist enabled:false> \
      -e DOCKRPCWHITELIST=<transmission rpc whitelist:127.0.0.1,::1> \
      -e DOCKRPCHOSTWHITELISTENABLED=<transmission rpc host whitelist enabled:false> \
      -e DOCKRPCHOSTWHITELIST=<transmission rpc host whitelist> \
      -e DOCKLPDENABLED=<transmission lpd enabled:false> \
      -e DOCKANTIBRUTEFORCEENABLED=<transmission anti-brute-force enabled:false> \
      -e DOCKANTIBRUTEFORCETHRESHOLD=<transmission anti-brute-force threshold:100> \
      -e DOCKSPEEDLIMITDOWNENABLED=<transmission speed limit down enabled:false> \
      -e DOCKSPEEDLIMITDOWN=<transmission speed limit down:100> \
      -e DOCKSPEEDLIMITUPENABLED=<transmission speed limit up enabled:false> \
      -e DOCKSPEEDLIMITUP=<transmission speed limit up:100> \
      -e DOCKALTSPEEDENABLED=<transmission alt speed enabled:false> \
      -e DOCKALTSPEEDDOWN=<transmission alt speed down:50> \
      -e DOCKALTSPEEDUP=<transmission alt speed up:50> \
      -e DOCKALTSPEEDTIMEENABLED=<transmission alt speed time enabled:false> \
      -e DOCKALTSPEEDTIMEBEGIN=<transmission alt speed time begin:0> \
      -e DOCKALTSPEEDTIMEEND=<transmission alt speed time end:0> \
      -e DOCKALTSPEEDTIMEDAY=<transmission alt speed time day:0> \
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

### `DOCKUMASK`

This variable is not mandatory and specifies which umask Transmission is using for downloads. it has default value `002`.

### `DOCKBLOCKLISTENABLED`

This variable is not mandatory and specifies if IP blocklist are active Transmission. it has default value `false`.

### `DOCKBLOCKLISTURL`

This variable is not mandatory and specifies the URL to be used for blocklist.

### `DOCKRPCENABLED`

This variable is not mandatory and specifies if RPC is enabled. it has default value `true`.

### `DOCKRPCPORT`

This variable is not mandatory and specifies the port to be used for RPC. it has default value `9092`.

### `DOCKRPCBINDADDRESS`

This variable is not mandatory and specifies the bind address to be used for RPC. it has default value `0.0.0.0`.

### `DOCKRPCAUTHENTICATIONREQUIRED`

This variable is not mandatory and specifies if RPC authentication is required. it has default value `true`.

### `DOCKRPCUSERNAME`

This variable is not mandatory and specifies the username to be used for RPC.

### `DOCKRPCPASSWORD`

This variable is not mandatory and specifies the password to be used for RPC.

### `DOCKRPCWHITELISTENABLED`

This variable is not mandatory and specifies if RPC whitelist is enabled. it has default value `false`.

### `DOCKRPCWHITELIST`

This variable is not mandatory and specifies the whitelist to be used for RPC. it has default value `127.0.0.1,::1`.

### `DOCKRPCHOSTWHITELISTENABLED`

This variable is not mandatory and specifies if RPC host whitelist is enabled. it has default value `false`.

### `DOCKRPCHOSTWHITELIST`

This variable is not mandatory and specifies the host whitelist to be used for RPC.

### `DOCKLPDENABLED`

This variable is not mandatory and specifies if lpd is enabled. it has default value `false`.

### `DOCKANTIBRUTEFORCEENABLED`

This variable is not mandatory and specifies if anti-brute-force is enabled. it has default value `false`.

### `DOCKANTIBRUTEFORCETHRESHOLD`

This variable is not mandatory and specifies the anti-brute-force threshold. it has default value `100`.

### `DOCKSPEEDLIMITDOWNENABLED`

This variable is not mandatory and specifies if speed limit down is enabled. it has default value `false`.

### `DOCKSPEEDLIMITDOWN`

This variable is not mandatory and specifies the speed limit down in KiB/s. it has default value `100`.

### `DOCKSPEEDLIMITUPENABLED`

This variable is not mandatory and specifies if speed limit up is enabled. it has default value `false`.

### `DOCKSPEEDLIMITUP`

This variable is not mandatory and specifies the speed limit up in KiB/s. it has default value `100`.

### `DOCKALTSPEEDENABLED`

This variable is not mandatory and specifies if alt speed is enabled. it has default value `false`.

### `DOCKALTSPEEDDOWN`

This variable is not mandatory and specifies the alt speed down in KiB/s. it has default value `50`.

### `DOCKALTSPEEDUP`

This variable is not mandatory and specifies the alt speed up in KiB/s. it has default value `50`.

### `DOCKALTSPEEDTIMEENABLED`

This variable is not mandatory and specifies if alt speed time is enabled. it has default value `false`.

### `DOCKALTSPEEDTIMEBEGIN`

This variable is not mandatory and specifies the alt speed time begin in HHMM format. it has default value `0`.

### `DOCKALTSPEEDTIMEEND`

This variable is not mandatory and specifies the alt speed time end in HHMM format. it has default value `0`.

### `DOCKALTSPEEDTIMEDAY`

This variable is not mandatory and specifies the alt speed time day as a bitmask (1=Sunday, 2=Monday, 4=Tuesday, 8=Wednesday, 16=Thursday, 32=Friday, 64=Saturday). Sum values for multiple days. it has default value `0`.

### `DOCKTELEGRAMBOTTOKEN`

This variable is not mandatory and specifices what Telegram Bot Token will be used to send notifications when a torrent is completed.

### `DOCKTELEGRAMCHATID`

This variable is not mandatory and specifices what Telegram Chat ID will be used to send notifications when a torrent is completed.

## Notes

* This container is built using [s6-overlay](https://github.com/just-containers/s6-overlay)
* The docker entrypoint can upgrade operating system at each startup. To enable this feature, just add `-e AUTOUPGRADE=1` at container creation.
* An helm chart is available of in the [chart folder](https://github.com/digrouz/docker-transmission/tree/master/chart) with an example [value.yaml](https://github.com/digrouz/docker-transmission/tree/master/chart/values.yaml)

## Issues

If you encounter an issue please open a ticket at [github](https://github.com/digrouz/docker-transmission/issues)
