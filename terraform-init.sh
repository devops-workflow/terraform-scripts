#!/bin/bash
# TODO:
#   use default region ??
org="wiser"
region="us-west-2"
service="cmp-service"

profile=${1:-saml}
[[ $(aws configure --profile ${profile} list 2>/dev/null) && $? -eq 0 ]] && \
  echo "Using AWS Profile: ${profile}" || \
  { echo "AWS Profile '${profile}' does not exist"; exit 1; }

ENV=$(AWS_PROFILE=${profile} aws iam list-account-aliases --output=text --query 'AccountAliases[0]' | sed "s/${org}-//")
echo "AWS env: $ENV"
BUCKET="${org}-$ENV-tf"
echo "Using bucket=$BUCKET"
rm -rf .terraform
AWS_PROFILE=${profile} ENV=$ENV TF_VAR_env=$ENV terraform init -upgrade \
     -backend-config "bucket=$BUCKET" \
     -backend-config "region=${region}" \
     -backend-config "key=services/${service}.tfstate"
