# K01: Insecure Workload Configurations

## Kubernetes

```shell
docker build -t ldynia/hackme-app:v5 -f devops/docker/v3.Dockerfile .
docker push ldynia/hackme-app:v5

kubectl apply -f devops/k8s/manifests/k01/hack4.pod.yaml
kubectl port-forward pod/hackme-app 8080:80
```

Visit app at [localhost:8080](http://localhost:8080/)

```shell
# Terminal no. 1
kubectl exec -it hackme-app -- htop

# Terminal no. 2
kubectl exec hackme-app -- stress-ng --cpu 8 --vm 4 --vm-bytes 2G --timeout 30s
```

# Mitigations

```yaml
apiVersion: v1
kind: Pod
...
spec:
  containers:
  - ...
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```