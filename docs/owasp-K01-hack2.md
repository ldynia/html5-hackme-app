# Root privilege escalation

This example demonstrates what could potentialy happened to an application, if an attacker had root access.

# Setup

```shell
docker build -t ldynia/hackme-app:v2 -f devops/docker/v2.Dockerfile
docker run --rm  --detach --name hackme-app --publish 8080:80 ldynia/hackme-app:v2
```

Visit app at [localhost:8080](http://localhost:8080/)

# Attack

## Docker

```shell
docker exec hackme-app rm -f /usr/share/nginx/html/index.html
```

## Kubernetes

```shell
kubectl exec hackme-app -- rm -f /usr/share/nginx/html/index.html
```

# Mitigations

Running the process inside of a container as the root user is a common misconfiguration. **Application processes should not run as root**. If the container were to be compromised, the attacker would have root-level privileges that allow actions such as starting a malicious process.

## Docker

```Dockerfile
USER nobody:nogroup
```

## Kubernetes

Obtain Ids of of user `nobody` and group `nogroup`.

```shell
cat /etc/passwd | grep nobody | cut -d ':' -f3
65534

cat /etc/group | grep nogroup | cut -d':' -f3
65534
```

```yaml
apiVersion: v1  
kind: Pod  
...
spec:  
  securityContext: 
    runAsGroup: 65534
    runAsNonRoot: true
    runAsUser: 65534
    ...
```