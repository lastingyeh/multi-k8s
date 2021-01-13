### Feed a config file to kubectl

    $ kubectl apply -f <filename>|<dirname>

    $ kubectl get services

    $ kubectl get pods

    # check at browser

    $ minikube ip

### Imperative vs Declartive (make action vs should be)

create that use cmd - define config that [Master] known how to apply it

### describe

    $ kubectl describe pod <objectname>
  
### Pod vs Deployment

1. single set of containers <=> set of identical pods (one or more)

2. one-off dev purposes <=> monitors the state of each pod, updating as necessary

3. rarely used directly in production <=> good for dev / production

### Update Image that deployment

- deleting pods manually (seems silly especially in Production)

- tag built that build image

- use an imperative command

      # eg. kubectl set image deployment/client-deployment client=lasting/multi-client:v1
      $ kubectl set image <objecttype>/<objectname> <containername> = <newimage>

### Configure the VM

- display at docker server in VM

      # win 10
      $ minikube docker-env
      $ @FOR /f "tokens=*" %i IN ('minikube -p minikube docker-env') DO @%i

      # mac
      $ eval $(minikube docker-env)

### Volume

- Persistent volume calim 

      $ kubectl get storageclass

      $ kubectl describe storageclass

- Persistent volume

  define at deploment / pod

### Secret (Imperative command to create against 'apply it')

    $ kubectl create secret generic <secretname> --from-literal key=value

    $ kubectl get secrets

### Ingress nginx 

- Installation

      # start at minikube
      $ minikube addons enable ingress

