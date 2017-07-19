#!/bin/bash

if [ ! -z $1 ]; then
  export AWS_DEFAULT_PROFILE=$1
fi

cd infra
BUCKET_NAME=$(terraform output bucket_name)
CLOUDFRONT_ID=$(terraform output cloudfront_id)
CLOUDFRONT_DOMAIN=$(terraform output cloudfront_domain)

cd ../
npm run build

aws s3 sync ./build s3://$BUCKET_NAME \
  --delete

aws cloudfront create-invalidation \
  --paths "/*" \
  --distribution-id $CLOUDFRONT_ID

echo "=> Deployed to $CLOUDFRONT_DOMAIN"
