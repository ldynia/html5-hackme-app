# Hack Me App

This stateless application was implemented for the purpose of being hacked.

## Installation

### Minikube

1. Install local kubernetes cluster with [Docker Desktop](https://www.docker.com/products/docker-desktop/)
    1. Open `Docker Desktop`
    1. In `Settings > Kubernetes` check `Enable Kubernetes` checkbox
    1. Restart `Docker Desktop`
1. Install [minikube](https://minikube.sigs.k8s.io/docs/start/) CLI
1. install [az](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) CLI
1. install `kubectl` with `az aks install-cli` command

```bash
# Start minikube
minkube status
minkube start
minkube dashboard &

# Use minikube context
kubectl config get-contexts
kubectl config set-context minikube
```

### Kubernetes Goat

- Read [kubernetes goat docs](https://madhuakula.com/kubernetes-goat/docs/)
- Read [OWASP Kubernetes Top Ten](https://owasp.org/www-project-kubernetes-top-ten/)
- Execute [OWASP Kubernetes Top Ten](https://madhuakula.com/kubernetes-goat/docs/owasp-kubernetes-top-ten)

1. Set up the cluster

    ```shell
    {
        git clone https://github.com/ldynia/html5-hackme-app.git --recurse-submodules;
        cd vendors/kubernetes-goat;
        chmod +x setup-kubernetes-goat.sh access-kubernetes-goat.sh;
        bash setup-kubernetes-goat.sh;
        bash access-kubernetes-goat.sh;
        cd ../../;
    }
    ```
    Visit [localhost:1234](http://localhost:1234)

## Exploit

```shell
# Create nginx app
````

Visit app on [localhost:8080](http://localhost:8080)

## The App

```shell
docker build -t ldynia/hackme-app -f devops/docker/v1.Dockerfile .
docker run -it -d --rm --name hackme-app -p 8080:80 ldynia/hackme-app
```