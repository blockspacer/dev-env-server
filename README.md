# Development Environment Server

Goal: 
Support Visual Studio Code based server side development
Including:

- VS Code behind KubePlatform OAUTH
- Dedicated Docker daemom per Code instance
- kns, kubectl and other kubernetes tools

This is alpha software

## Manual Install

### Docker CLI

```bash
$ sudo apt-get update
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

```bash
export DOCKER_HOST=tcp://0.0.0.0:2375
```
