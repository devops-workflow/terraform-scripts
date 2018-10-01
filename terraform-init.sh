#!/bin/bash
# TODO:
#   move org to Variables
#   move region to variable
#   move state key to variable
profile=${1:-saml}
[[ $(aws configure --profile ${profile} list 2>/dev/null) && $? -eq 0 ]] && \
  echo "Using AWS Profile: ${profile}" || \
  { echo "AWS Profile '${profile}' does not exist"; exit 1; }

ENV=$(AWS_PROFILE=${profile} aws iam list-account-aliases --output=text --query 'AccountAliases[0]' | sed 's/wiser-//')
echo "AWS env: $ENV"
BUCKET="wiser-$ENV-tf"
echo "Using bucket=$BUCKET"
rm -rf .terraform
AWS_PROFILE=${profile} ENV=$ENV TF_VAR_env=$ENV terraform init -upgrade \
     -backend-config "bucket=$BUCKET" \
     -backend-config "region=us-west-2" \
     -backend-config "key=services/cmp-service.tfstate"
