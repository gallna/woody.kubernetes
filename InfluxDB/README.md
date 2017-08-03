
# Prometheus and Grafana Setup

https://github.com/giantswarm/kubernetes-prometheus

```bash
kubectl apply \
  --filename https://raw.githubusercontent.com/giantswarm/kubernetes-prometheus/master/manifests-all.yaml

kube create -f grafana-import-dashboards.configmap.yaml
kube create -f import-dashboards-job.yaml
kube delete -f import-dashboards-job.yaml
```

https://grafana.net/dashboards/2
https://grafana.net/dashboards/162
