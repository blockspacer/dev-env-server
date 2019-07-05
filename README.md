# Development Environment Server

Goal:
Support Visual Studio Code based server side development
Including:

- VS Code instance running on Kubernetes for browser usage (thanks to [coder](https://github.com/cdr/code-server))
- Take advantage of KubePlatforms OAUTH
- Dedicated Docker daemon per VS Code instance
- kns, kubectl and other kubernetes or development tools

This is alpha software

![Screenshot](/doc/assets/ide.png)

## Deployment

These manifests use kustomize (e.g. `kubectl apply -k .`) for deployment. It is preconfigured to take advantage of [Kube Platform](https://kubeplatform.dev/).

- a StatefulSet is used for simpler usage of Persistent Volume Claims (no other reason)
- Ingress use the OAUTH facility of Kube Platform
- The Role Binding of the Pods Service Accound defines the rights of the Kubernetes tools started in VS Code embedded shell

## Used Container

### Docker DinD Container

DevEnvServer uses the official Docker DinD image as a sidekick to allow using `docker` commands. While this is a nice feature, it also has some drawbacks. So, be shure you've read [Using Docker-in-Docker](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)

### Create Kubeconfig Container

Most Kubernetes tools and helper do need a valid kubeconfig file, others work with an in cluster configuration. To gain flexibility here, an init container is used to create a kubeconfig file based on the Pods ServiceAccount. This is a simple bash script.

### Development Environment Server Container

Inherited from `codercom/code-serve` some environment variables are added, and binaries for `kubectl`, `stern`, `go` and others. This should serve as a starting point to create own Dockerfiles which fit better to the own requirements.

## Volumes and Mounts

For now 3 persistent Volumes are used:

- for `/var/lib/docker` used by the Docker container. Not only to preserve the Container Images but also to allow a proper overlay2 AUFS usage
- for `/home/coder/.local` to persist VS Code settings
- for `/home/coder/project` to provide basic project space

The generated kubeconfig is stored in a `emptyDir` Volume at `/home/coder/.kube`. Thus it is tied to the Pods lifecycle.
