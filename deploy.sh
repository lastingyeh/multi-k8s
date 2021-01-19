docker build -t lasting/multi-client:latest -t lasting/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lasting/multi-server:latest -t lasting/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lasting/multi-worker:latest -t lasting/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lasting/multi-client:latest
docker push lasting/multi-server:latest
docker push lasting/multi-worker:latest

docker push lasting/multi-client:$SHA
docker push lasting/multi-server:$SHA
docker push lasting/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=lasting/multi-server:$SHA
kubectl set image deployments/client-deployment server=lasting/multi-client:$SHA
kubectl set image deployments/worker-deployment server=lasting/multi-worker:$SHA