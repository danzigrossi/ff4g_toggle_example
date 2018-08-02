#!/bin/sh
IMAGE_REGISTRY="053037425401.dkr.ecr.us-east-1.amazonaws.com"
IMAGE_NAME="bluetec/telemetry-enrichment-processor"
IMAGE_TAG="latest"
IMAGE_REMOTE_FULL=$IMAGE_REGISTRY/$IMAGE_NAME:$IMAGE_TAG
echo "Pushing image $IMAGE_REMOTE_FULL" 

echo 'Logging in to AWS Registry (credentials must be configured)'
$(aws ecr get-login --no-include-email --region us-east-1)

echo 'Tagging image'
docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_REMOTE_FULL

echo 'Pushing image to AWS Registry'
docker push $IMAGE_REMOTE_FULL

echo 'Finished'

