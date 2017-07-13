# Helm

# Helm charts

https://github.com/kubernetes/charts

# Magento Install

# Using values.yaml

helm install --name magento -f ../magento-values.yaml stable/magento
helm upgrade magento -f ../magento-values.yaml stable/magento
helm delete --purge magento

# CLI:

helm install --name magento --set magentoUsername=admin,magentoPassword=password,mariadb.mariadbRootPassword=secretpassword stable/magento

###############################################################################

###############################################################################
### ERROR: You did not provide an external host in your 'helm install' call ###
###############################################################################

This deployment will be incomplete until you configure Magento with a resolvable
host. To configure Magento with the URL of your service:

## Get the Magento URL by running:

APP_HOST=$(kubectl get svc --namespace default magento-magento --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
APP_PASSWORD=$(kubectl get secret --namespace default magento-magento -o jsonpath="{.data.magento-password}" | base64 --decode)
APP_DATABASE_PASSWORD=$(kubectl get secret --namespace default magento-mariadb -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)

helm upgrade magento --set "magentoHost=$(
  kubectl get svc --namespace default magento-magento --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}"
  ),magentoUsername=admin,magentoPassword=password,mariadb.mariadbRootPassword=secretpassword" stable/magento

### Snippets

kube port-forward  $(kube get pod | awk '/magento-magento/{print $1}') 8877:443 8888:80 && xdg-open 127.0.0.1:8888
kube logs -f $(kube get pod | awk '/magento-magento/{print $1}')
kube logs -f $(kube get pod | awk '/magento-mariadb/{print $1}')
