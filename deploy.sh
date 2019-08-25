docker build -t urdavid/multi-client:latest -t urdavid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t urdavid/multi-server:latest -t urdavid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t urdavid/multi-worker:latest -t urdavid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push urdavid/multi-client:latest
docker push urdavid/multi-server:latest
docker push urdavid/multi-worker:latest

docker push urdavid/multi-client:latest:$SHA
docker push urdavid/multi-server:latest:$SHA
docker push urdavid/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=urdavid/multi-server:$SHA
kubectl set image deployments/client-deployment client=urdavid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=urdavid/multi-worker:$SHA
