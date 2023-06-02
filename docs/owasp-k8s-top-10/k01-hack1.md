# K01: Insecure Workload Configurations

# Permission to write to file system

This exploit demonstrates what could potentialy happened to an application, if an attacker had permission to write to a file system.

# Setup

## Docker 

```shell
docker build -t ldynia/hackme-app:v1 -f devops/docker/v1.Dockerfile .
docker run --detach --name hackme-app --publish 8080:80 --rm ldynia/hackme-app:v1
```

## Kubernetes

```shell
docker build -t ldynia/hackme-app:v1 -f devops/docker/v1.Dockerfile .
docker push ldynia/hackme-app:v1

kubectl apply -f devops/k8s/manifests/k01/hack1.pod.yaml
kubectl port-forward pod/hackme-app 8080:80
```

Visit app at [localhost:8080](http://localhost:8080/)

# Attack

## Docker

```shell
docker exec hackme-app bash -c "echo '<\!DOCTYPE html><html lang=\"en\"><head><style> body { align-items: center; background-color: black; display: flex; height: 100vh; justify-content: center; } </style></head><body><img src=\"https://raw.githubusercontent.com/ldynia/html5-hackme-app/main/app/src/assets/img/h1sub.png\"></body></html>' > /usr/share/nginx/html/index.html"
```

### Kubernetes

```shell
kubectl exec hackme-app -- bash -c "echo '<\!DOCTYPE html><html lang=\"en\"><head><style> body { align-items: center; background-color: black; display: flex; height: 100vh; justify-content: center; } </style></head><body><img src=\"https://raw.githubusercontent.com/ldynia/html5-hackme-app/main/app/src/assets/img/h1sub.png\"></body></html>' > /usr/share/nginx/html/index.html"
```

# Mitigations

To limit the impact of a compromised container, it is recommended to **utilize read-only filesystems when possible.** This prevents a malicious process or application from writing back to the host system.

## Docker

Be aware that the below example will not work in this context. Example only shows how to remove write access to folders and files.

```shell
chmod -R u=rx,go=rx /usr/share/nginx/html
chattr +i /usr/share/nginx/html/index.html
```

## Kubernetes

```yaml
apiVersion: v1
kind: Pod
...
spec:
  containers:
    - ...
      securityContext: 
        readOnlyRootFilesystem: true
```

# Links

- [read only filesystems in docker and kubernetes](https://www.thorsten-hans.com/read-only-filesystems-in-docker-and-kubernetes/)