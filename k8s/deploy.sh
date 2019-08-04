docker build -t vipinjain/multi-client:latest -t vipinjain/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vipinjain/multi-server:latest -t vipinjain/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vipinjain/multi-worker:latest -t vipinjain/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push vipinjain/multi-client:latest
docker push vipinjain/multi-server:latest
docker push vipinjain/multi-worker:latest

docker push vipinjain/multi-client:$SHA
docker push vipinjain/multi-server:$SHA
docker push vipinjain/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vipinjain/multi-server:$SHA
kubectl set image deployments/client-deployment client=vipinjain/multi:client:$SHA
kubectl set image deployments/worker-deployment worker=vipinjain/multi-worker:$SHA
