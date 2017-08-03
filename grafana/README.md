
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

kubectl create -f https://raw.githubusercontent.com/kubernetes-incubator-retired/kubedash/master/deploy/bundle.yaml

read ns name others < <(kube get pod --all-namespaces | awk '/monitoring-grafana/');
kube -n $ns exec $name grafana-cli plugins install raintank-kubernetes-app

kubectl delete daemonsets -n kube-system snap
kubectl delete deployments -n kube-system snap-kubestate-deployment
kubectl delete configmaps -n kube-system snap-tasks
kubectl delete configmaps -n kube-system snap-tasks-kubestate
