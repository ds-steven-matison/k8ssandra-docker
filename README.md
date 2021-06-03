# k8ssandra-docker

## Install k8ssandra per [k8ssandra.io](https://k8ssandra.io/)

```
helm install -f k8ssandra.yaml k8ssandra k8ssandra/k8ssandra
watch kubectl get pods
```

## User and pass needed for local testing

```
kubectl get secret k8ssandra-superuser -o jsonpath="{.data.username}" | base64 --decode ; echo
kubectl get secret k8ssandra-superuser -o jsonpath="{.data.password}" | base64 --decode ; echo
```

## Port forwarding for local access

```
kubectl port-forward svc/k8ssandra-dc1-stargate-service 8080 8081 8082 9042
```

## Use cqlsh to load demo.cql statements

```
kubectl exec -it k8ssandra-dc1-default-sts-0 -- bash -c "wget https://raw.githubusercontent.com/ds-steven-matison/k8ssandra-docker/master/demo.cql -P /tmp && /opt/cassandra/bin/cqlsh localhost 9042 -u k8ssandra-superuser -p [pass above] -f /tmp/demo.cql"
```

## Role out app 

```
kubectl apply -f deployment.k8s.yaml
```

## Access app locally

```
kubectl port-forward deployments/k8ssandra-docker  1337:80
```
After port fwd access app @ [http://localhost:1337](http://localhost:1337).

## Connect to app container

```
kubectl exec -it deployments/k8ssandra-docker /bin/bash
```
:bulb: Use the command <b></i>tail -f /var/log/php5-fpm.log</i></b> to check PHP Errors.  You can also find the app source at <b></i>/usr/share/nginx/html</i></b>.

## Create your own dockerhub image

Current Docker [image](https://hub.docker.com/repository/docker/dsstevenmatison/k8ssandra-docker). 

1. Git clone [this repo]
2. Next build and push image
```
docker build . -t dsstevenmatison/k8ssandra-docker
docker push dsstevenmatison/k8ssandra-docker
```
:warning: This sample above is mine, you would change to your dockerhubrepo/appname.  Then in the deployment.k8s.yaml file you reference the full docker.io string to image.  For example: <b></i>docker.io/dsstevenmatison/k8ssandra-docker:latest</i></b>.

3. Edit deployment.k8s.yaml accordingly then
```
kubectl apply -f deployment.k8s.yaml
```
4. If you are just updating the image, murder the pod and it will recreate w/ new image
```
kubectl delete pod k8ssandra-docker-6fd6b955f6-6ldk5
```
:bulb: Monitor your <b></i>watch kubectl get pods</i></b> terminal and watch this pod terminate and recreate!!!

## Cluster should look like

```
NAME                                                READY   STATUS      RESTARTS   AGE
k8ssandra-reaper-operator-79fd5b4655-qvgls          1/1     Running     0          152m
k8ssandra-cass-operator-7d5df6d49-pc5cj             1/1     Running     0          152m
k8ssandra-grafana-5c6d5b8f5f-w67fw                  2/2     Running     0          152m
k8ssandra-kube-prometheus-operator-85695ffb-6fpfl   1/1     Running     0          152m
prometheus-k8ssandra-kube-prometheus-prometheus-0   2/2     Running     1          151m
k8ssandra-dc1-default-sts-0                         2/2     Running     0          151m
k8ssandra-reaper-schema-cqgm6                       0/1     Completed   0          148m
k8ssandra-reaper-7bb77d575c-n9sv9                   1/1     Running     0          148m
k8ssandra-dc1-stargate-646d6bcd68-d46rp             1/1     Running     0          152m
mk8ssandra-docker-6fd6b955f6-v66xs                  1/1     Running     0          3m45s
```