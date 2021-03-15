#!/bin/bash

#export_env_var
cd s3bucket
if [ -z ${tf_bucket_name} ];
then
echo -n "Please enter bucket name for tf state: "
read bucket_name
export tf_bucket_name=`echo $bucket_name`
fi

#create bucket
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' variables.tf
terraform init
terraform apply -auto-approve

#network
cd ../network
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' main.tf
terraform init
terraform apply -auto-approve

#security_groups
cd ../security_groups
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' main.tf
terraform init
terraform apply -auto-approve

#bastion_server
cd ../bastion
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' main.tf
terraform init
terraform apply -auto-approve

#asg_instances
cd ../webservers
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' main.tf
terraform init
terraform apply -auto-approve

#alb
cd ../alb
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' main.tf
terraform init
terraform apply -auto-approve

#rds
cd ../rds
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' main.tf
terraform init
terraform apply -auto-approve

#cache
cd ../cache
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' main.tf
terraform init
terraform apply -auto-approve



cd ..