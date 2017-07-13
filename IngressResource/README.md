# Traefik Ingress

`helm install stable/traefik --name traefik --namespace kube-system`

Specify each parameter using the --set key=value[,key=value] argument to helm install. For example:

```bash
$ helm install --name traefik --namespace kube-system \
  --set dashboard.enabled=true,dashboard.domain=ipsec.wrrr.online,kubernetes.labelSelector="realm=public" stable/traefik
```

The above command enables the Traefik dashboard on the domain ipsec.wrrr.online. Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example:

`helm install --name traefik --namespace kube-system --values traefik-values.yaml stable/traefik`

```yaml
# traefik-values.yaml:
dashboard:
  enabled: true
  domain: ipsec.wrrr.online
  kubernetes:
    labelSelector: realm=public
```

```bash
helm upgrade traefik --namespace kube-system --values traefik-values.yaml stable/traefik
helm delete --purge traefik
kubectl describe service traefik-traefik -n kube-system
```

# Rancher Ingress

https://docs.rancher.com/rancher/v1.1/en/kubernetes/ingress/

host-based-ingress.yml
path-based-ingress.yml
scaled-ingress.yml
simple-ingress.yml
tls-ingress.yml

## Fabric8 exposecontroller

```bash
cat <<EOF | kubectl replace -f -
apiVersion: "v1"
data:
  config.yml: |-
    exposer: "LoadBalancer"
    domain: "wrrr.online"
kind: "ConfigMap"
metadata:
  name: "exposecontroller"
EOF
```
