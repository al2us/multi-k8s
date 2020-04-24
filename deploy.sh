docker build -t al2us/multi-client:latest -t al2us/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t al2us/multi-server:latest -t al2us/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t al2us/multi-worker:latest -t al2us/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push al2us/multi-client:latest
docker push al2us/multi-worker:latest
docker push al2us/multi-server:latest

docker push al2us/multi-client:$SHA
docker push al2us/multi-worker:$SHA
docker push al2us/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=al2us/multi-server:$SHA
kubectl set image deployments/client-deployment client=al2us/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=al2us/multi-worker:$SHA