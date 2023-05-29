# Privileged containers should be disallowed

# Problem

The dockers's run `--privileged` flag lifts all the limitations enforced by the device cgroup controller, allowing the container to do almost everything what the host can do.

# Mitigations

Running the process inside of a container as the root user is a common misconfiguration. **Application processes should not run as root**. If the container were to be compromised, the attacker would have root-level privileges that allow actions such as starting a malicious process.

## Kubernetes

```yaml
apiVersion: v1  
kind: Pod  
...
spec:  
  containers:  
  ...
  securityContext:  
    privileged: false
```

# Links

- [privileged](https://docs.docker.com/engine/reference/commandline/run/#privileged)
- [Don't run with privileged:true](https://www.youtube.com/watch?v=tpsDgMtNObo)