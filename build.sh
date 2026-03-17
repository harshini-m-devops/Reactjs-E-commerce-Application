#!/bin/bash

echo "========== BUILD STARTED =========="

IMAGE_NAME="devops-app"

docker build -t $IMAGE_NAME .

if [ $? -eq 0 ]; then
  echo "Docker Image Built Successfully"
else
  echo "Build Failed"
  exit 1
fi

echo "========== BUILD COMPLETED =========="
