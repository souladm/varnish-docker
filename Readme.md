# varnish-alpine-docker

![varnish docker](https://miro.medium.com/max/1400/1*_KioJT01kB6QkAFUwIzu6Q.png)

Varnish docker image based on Alpine Linux.

## Environment variables
* `VARNISH_BACKEND_ADDRESS` - Hostname or ip of your backend server. (Required if VARNISH_CONFIG_FILE missing)
* `VARNISH_BACKEND_PORT` - TCP port of your backend.  Default is 80.
* `VARNISH_MEMORY` - Memory whish Varnish can use for caching. Default is 1G.
* `VARNISH_CONFIG_FILE` - Path to your vcl file. (Required if VARNISH_BACKEND_ADDRESS missing)

## System requirements

- `docker >= 18.0` _(install: `curl -fsSL get.docker.com | sudo sh`)_
- `make >= 4.1` _(install: `apt-get install make`)_

## Quick start

Run with defaults:

```bash
$ docker run -itd --name=varnish-alpine kosar/varnish:tag
```

Specify your backend configuration:

```bash
docker run -e VARNISH_BACKEND_ADDRESS=IP \
           -e VARNISH_BACKEND_PORT=PORT \
           -e VARNISH_MEMORY=MEM \
           -itd --name=varnish-alpine kosar/varnish:tag
```

Alternatively, specify a varnish config file

```bash
docker run -e VARNISH_CONFIG_FILE=/etc/varnish/default.vcl \
           -v /LOCAL/PATH/TO/default.vcl:/etc/varnish/default.vcl \
           -itd --name=varnish-alpine kosar/varnish:tag
```

Build image locally (make required):

 ```bash
$ git clone git@github.com:souladm/varnish-docker.git
$ cd varnish
$ make build tag
```

## Work with application

Most used commands declared in the `./Makefile` file. For more information exec in your terminal `make help`.

Here are list of them:

Command signature | Description
----------------- | -----------
`help`            | Show this help
`build`           | Build Docker image Usage: $ make build "tag"
`create-tag`      | Remove images from local registry. Usage: $ make create-tag "existing-tag" "new-tag"
`clean`           | Remove images from local registry. Usage: $ make clean
`login`           | Log in to a remote Docker registry. Usage: $ make login
`new`             | Create new tag from template. DANGER! EXPERIMENTAL! Usage: $ make new "tag". You can see all tags here: https://varnish-cache.org/releases/index.html
`pull`            | Pull specific tag from the registry. Usage: $ make pull "tag".
`push`            | Pull specific tag from the registry. Usage: $ make push "tag".
`run`             | Start varnish comtainer for test with test parameters. In other case you need to run command manually! Usage: $ make run "tag".
`stop`            | Stop and remove container. Usage: $ make stop "tag".
`shell`           | Start shell into varnish container. Usage: $ make shell "tag".
