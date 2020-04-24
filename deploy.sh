docker build -t 2aldous/multi-client:latest -t 2aldous/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 2aldous/multi-server:latest -t 2aldous/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 2aldous/multi-worker:latest -t 2aldous/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push 2aldous/multi-client:latest
docker push 2aldous/multi-worker:latest
docker push 2aldous/multi-server:latest

docker push 2aldous/multi-client:$SHA
docker push 2aldous/multi-worker:$SHA
docker push 2aldous/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=2aldous/multi-server:$SHA
kubectl set image deployments/client-deployment client=2aldous/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=2aldous/multi-worker:$SHA