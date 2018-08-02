#!/bin/sh
IMAGE_REGISTRY="053037425401.dkr.ecr.us-east-1.amazonaws.com"
IMAGE_NAME="bluetec/telemetry-enrichment-processor"
IMAGE_TAG="latest"
IMAGE_REMOTE_FULL=$IMAGE_REGISTRY/$IMAGE_NAME:$IMAGE_TAG
echo "Pulling image $IMAGE_REMOTE_FULL" 

echo 'Logging in to AWS Registry (credentials must be configured)'
$(aws ecr get-login --no-include-email --region us-east-1)

echo 'Pulling image from AWS Registry'
docker pull $IMAGE_REMOTE_FULL

echo 'Tagging local image'
docker tag $IMAGE_REMOTE_FULL $IMAGE_NAME:$IMAGE_TAG

echo 'Running compose'
docker-compose up -d

echo 'Finished'