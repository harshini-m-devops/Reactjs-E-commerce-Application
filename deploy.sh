#!/bin/bash

echo "========== DEPLOYMENT STARTED =========="

CONTAINER_NAME="devops-app"
IMAGE_NAME="devops-app"

docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

docker run -d -p 80:80 --name $CONTAINER_NAME $IMAGE_NAME

if [ $? -eq 0 ]; then
  echo "Deployment Successful"
else
  echo "Deployment Failed"
  exit 1
fi

echo "========== DEPLOYMENT COMPLETED =========="
