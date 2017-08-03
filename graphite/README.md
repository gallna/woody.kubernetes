# Installing Graphite

```bash
### docker

docker run -d\
 --name graphite\
 --restart=always\
 -p 80:80\
 -p 2003-2004:2003-2004\
 -p 2023-2024:2023-2024\
 -p 8125:8125/udp\
 -p 8126:8126\
 graphiteapp/graphite-statsd

### kubernetes

kubectl --namespace kube-system run graphite \
  --image=graphiteapp/graphite-statsd \
  --restart=Always \
  --port=80:80 --expose \
  --port=2003 \
  --port=2004 \
  --port=2023 \
  --port=2024 \
  --port=8125/udp \
  --port=8126

### delete

kubectl --namespace kube-system delete deployment graphite
```

https://github.com/giantswarm/kubernetes-prometheus

```bash
kubectl apply --filename https://raw.githubusercontent.com/giantswarm/kubernetes-prometheus/master/manifests-all.yaml

kube create -f grafana-import-dashboards.configmap.yaml
kube create -f import-dashboards-job.yaml
kube delete -f import-dashboards-job.yaml
```

https://grafana.net/dashboards/2
https://grafana.net/dashboards/162
