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

### CICD work flow

- create '.travis.yml'

- create service account from gcloud

      - set role: IAM > Service Account > set [Role: Kubernetes Engine Admin]

      - download <serviceaccount-xx>.json

- encrypt <serviceaccount-xx>.json

      # use ruby container & install travis cli in it.
      $ cd ../complex
      $ docker run -it -v %cd%:/app ruby
      
      # install travis (# /app)
      $ gem install travis

### Set image version (practical)

- get $Git_SHA

      $ git rev-parse HEAD
      # check $Git_SHA
      $ git log

- set image

      $ docker build -t lasting/mutli-client:latest -t lasting/multi-client:$Git_SHA -f ./client/Dockerfile.dev ./client

### Set secret

- at cloud shell (config)

      $ gcloud config set project <google-project-id>

      $ gcloud config set compute/zone <location>

      $ gcloud container clusters get-credentials <cluster-name>

- create secret

      $ kubectl create secret generic pgpassword --from-literal PGPASSWORD=mypgpassword

### Install Helm

- https://helm.sh/docs/intro/install/ > from script

### Create Tiller

- Create Service Account --namespace kube-system tiller

      $ kubectl create serviceaccount --namespace kube-system tiller

- Create a new clusterrolebinding with the role 'cluster-admin' and assign it to service account 'tiller'

      $ kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

- Init helm

      $ helm init --service-account tiller --upgrade

### Helm V3 (removes the user of Tiller)

1. Install Helm V3:
      
       $ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
      
       $ chmod 700 get_helm.sh
        
       $ ./get_helm.sh

2. Skip the commands run in the 'Create Tiller'

3. Install Ingress-nginx

       $ helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

       $ helm install my-release ingress-nginx/ingress-nginx
 
Important: manually upgrade your cluster to at least the verison specified

    $ gcloud container clusters upgrade <YOUR_CLUSTER_NAME> --master --cluster-version 1.16

### Structure

Traffic -> Google cloud Load Balancer -> Load Balancer<Service> -> nginx<Deployment> + Ingress Config -> Multi ClusterIPs<Service>

### HTTPS Setup with kubernetes

1. purchase domain name ($10 USD) 
      
      [google domain](https://domains.google.com/registrar/search)

2. Cert Manager

- Certificate ('secret' stored): Object describing details about the certificate that should be obtained

- Issuer: Object telling cert manager where to get the certificate from

