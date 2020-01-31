# docker-transmission
Installs Transmission into an Alpine container. It supports mail notifications through `ssmtp`.

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



