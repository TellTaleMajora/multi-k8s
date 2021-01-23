docker build -t telltalemajora/multi-client:latest -t telltalemajora/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t telltalemajora/multi-server:latest -t telltalemajora/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t telltalemajora/multi-worker:latest -t telltalemajora/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push telltalemajora/multi-client:latest
docker push telltalemajora/multi-server:latest
docker push telltalemajora/multi-worker:latest

docker push telltalemajora/multi-client:$SHA
docker push telltalemajora/multi-server:$SHA
docker push telltalemajora/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=telltalemajora/multi-server:$SHA
kubectl set image deployments/client-deployment client=telltalemajora/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=telltalemajora/multi-worker:$SHA