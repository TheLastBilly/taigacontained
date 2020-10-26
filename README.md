# TaigaContained
This is a container image built for [Taiga.io](https://www.taiga.io/). It was based on another container image for the same piece of sofware named [docker-taiga](https://github.com/docker-taiga/taiga). The reason I made this one was beacuse of some issues I was encountering with **docker-taiga**, and I realized I was spending too much time trying to troubleshoot it, so I decided to make my own instead. Just to be clear, I'm **NOT** trying to imply that **docker-taiga** is a broken piece of software or anything like that, it's just that this time, for my particular system, it was not working properly. **docker-taiga** has a lot more work put into it than my attempt at containing **taiga**, so I'd recommend you try installing it before using this repository.

## Requirements
- docker
- docker-compose

You can learn how to install them on you distribution of choice in [here](https://docs.docker.com/get-docker/).

## Setup
As far as setting up **TaigaContained** contaied goes, you'll only need to worry about two files: *docker-compose.yml* and *variables.env*.

### docker-compose.yml
If you're familiar with **docker** and **docker-compose** files, then you probably don't need much help here. If not, then here's something you can change without worrying about it too much.

```yml
    ports:
        - 9200:443
```
Here we define port **9200** as the default port for **taiga**, this is the port that would be exposed to the outside world from docker. For example, right now the address for taiga would be `https://mydomain:9200`. 

***Note:*** *Please do not modify the value of `443` in the same line, as it's required by* ***TaigaContained***.

### variables.env
Here are the variables used to defined the internals of **TaigaContained**. Here's a quick breakdown of some of them:

```
TAIGA_DOMAIN=localhost
```
Defines the domain **taiga** will use

```
TAIGA_PORT=9200
```
Defines the port that **taiga** will use

***Note:*** *The value of `TAIGA_PORT` must be the same as the one specified in the `ports` section for the `app` service in the* ***docker-compose.yml*** *file.*
