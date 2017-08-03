# Kubernetes deployments

This repository contains a number of tutorials/definitions, bash scripts and utilities used to build **wrrr** project and deployed to Kubernetes.

## Quick overview:

Refer to the Kubernetes documentation for how to execute the tutorials. See [Kubernetes Examples](https://github.com/kubernetes/examples) and [Example Guidelines](https://github.com/kubernetes/kubernetes/tree/master/examples) to get more tutorials

Directory tree as a **content overview**:

```
├── cassandra
│   ├── image
│   └── java
├── elasticsearch
│   └── elasticsearch2
├── grafana
│   ├── bin
│   └── snap
├── graphite
├── graylog2
│   ├── config
│   ├── content-packs
│   └── extractors
├── InfluxDB
├── IngressResource
│   └── rancher
├── notebooks
├── PersistentVolumes
│   ├── efs.provisioner
│   ├── external-provisioners
│   ├── glusterfs.provisioner
│   └── nfs-client.provisioner
├── rancher
│   ├── deployment
│   └── service
├── spark
│   └── spark-gluster
└── telegraf
```

## Snippets

### Export all deployment/services/... from current namespace

```bash
kube.yaml get deployment -o=name | parallel 'kubectl get {1} -o=yaml > orchestration/kubernetes/rancher/{1}.yaml'
kube.yaml get service -o=name | parallel 'kubectl get {1} -o=yaml > orchestration/kubernetes/rancher/{1}.yaml'
```

### Gitlab Docker Registry secrets

```bash
kubectl create secret docker-registry gitlab-secret \
  --docker-server=registry.gitlab.com \
  --docker-username=my@email.com \
  --docker-password=password \
  --docker-email=my@email.com
```

### kubectl run

```bash
# Start a single instance of nginx.
kubectl run nginx --image=nginx
# Dry run. Print the corresponding API objects without creating them.
kubectl run nginx --image=nginx --dry-run
# Start a replicated instance of nginx.
kubectl run nginx --image=nginx --replicas=5
# Start the nginx container using the default command, but use custom arguments (arg1 .. argN) for that command.
kubectl run nginx --image=nginx -- <arg1> <arg2> ... <argN>
# Start the nginx container using a different command and custom arguments.
kubectl run nginx --image=nginx --command -- <cmd> <arg1> ... <argN>
# Start a single instance of nginx, but overload the spec of the deployment with a partial set of values parsed from JSON.
kubectl run nginx --image=nginx --overrides='{ "apiVersion": "v1", "spec": { ... } }'

# Start a single instance of hazelcast and let the container expose port 5701 .
kubectl run hazelcast --image=hazelcast --port=5701
# Start a single instance of hazelcast and set environment variables "DNS_DOMAIN=cluster" and "POD_NAMESPACE=default" in the container.
kubectl run hazelcast --image=hazelcast --env="DNS_DOMAIN=cluster" --env="POD_NAMESPACE=default"
# Start a pod of busybox and keep it in the foreground, don't restart it if it exits.
kubectl run -i -t busybox --image=busybox --restart=Never

# Start the perl container to compute π to 2000 places and print it out.
kubectl run pi --image=perl --restart=OnFailure -- perl -Mbignum=bpi -wle 'print bpi(2000)'
# Start the cron job to compute π to 2000 places and print it out every 5 minutes.
kubectl run pi --image=perl --restart=OnFailure --schedule="0/5 * * * ?" -- perl -Mbignum=bpi -wle 'print bpi(2000)'
```
