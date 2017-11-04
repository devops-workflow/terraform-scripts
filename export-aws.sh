#!/bin/bash
#
# Export AWS resources to Terraform files
#
aws_profile=$1
aws_resources='alb asg cwa dbpg dbsg dbsn ec2 ecc ecsn efs eip elb iamg iamgm iamgp iamip iamp iampa iamr iamrp iamu iamup igw kmsa kmsk lc nacl nat nif r53r r53z rds rs rt rta s3 sg sn sqs vgw vpc'
for R in ${aws_resources}; do
  terraforming ${R} --profile ${aws_profile} > ${R}.tf
done
