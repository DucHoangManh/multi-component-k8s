docker build -t dhmhub/mclient:latest -t dhmhub/mclient:$SHA -f ./client/Dockerfile ./client
docker build -t dhmhub/mserver:latest -t dhmhub/mserver:$SHA -f ./server/Dockerfile ./server
docker build -t dhmhub/mworker:latest -t dhmhub/mworker:$SHA -f ./worker/Dockerfile ./worker
docker push dhmhub/mclient:latest
docker push dhmhub/mclient:$SHA
docker push dhmhub/mserver:latest
docker push dhmhub/mserver:$SHA
docker push dhmhub/mworker:latest
docker push dhmhub/mworker:$SHA


kubectl apply -f k8s
kubectl set image deployment/server-deployment server=dhmhub/mserver:$SHA
kubectl set image deployment/client-deployment client=dhmhub/mclient:$SHA
kubectl set image deployment/worker-deployment worker=dhmhub/mworker:$SHA
