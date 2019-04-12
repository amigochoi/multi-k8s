docker build -t amigochoi/multi-client:latest amigochoi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amigochoi/multi-server:latest amigochoi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amigochoi/multi-worker:latest amigochoi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push amigochoi/multi-client:latest
docker push amigochoi/multi-server:latest
docker push amigochoi/multi-worker:latest

docker push amigochoi/multi-client:$SHA
docker push amigochoi/multi-server:$SHA
docker push amigochoi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amigochoi/multi-server:$SHA
kubectl set image deployments/client-deployment client=amigochoi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amigochoi/multi-worker:$SHA
