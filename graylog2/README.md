# graylog-kube
# graylog cluster in kubernetes
# Steps to install graylog cluster

### 1. Make sure kubectl is up and working , connecting to kubenetes
### 2. Run graylog cluster
```
 kubectl create -f elasticsearch-deployment.yaml,elasticsearch-service.yaml,graylog-service.yaml,graylog-deployment.yaml,mongo-service.yaml,mongo-deployment.yaml
```
### 3. Forward port 9000
```
 kubectl port-forward graylog-3226681439-97w36 9000:9000
```

--tcp --port 3514 --rfc3164
--tcp --port 5514 --rfc5424
--udp --port 514

while true; do
  logger $(shuf -n 11 /usr/share/dict/words | paste -d" " -s) --tag test --stderr -p local3.info --id=$$ \
    --server graylog.wrrr.online --rfc3164 --tcp --port 3514
  sleep 1;
done

while true; do
  logger $(shuf -n 11 /usr/share/dict/words | paste -d" " -s) --tag test --stderr -p local3.info --id=$$ \
    --server graylog.wrrr.online --tcp --port 5514 --rfc5424
  sleep 1;
done

while true; do
  logger $(shuf -n 11 /usr/share/dict/words | paste -d" " -s) --tag test --stderr -p local3.info --id=$$ \
    --server 10.192.76.79 --udp --port 514
  sleep 1;
done
