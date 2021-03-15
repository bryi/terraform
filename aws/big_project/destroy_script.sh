#!/bin/bash

#порядок ресурсов обратен порядку в скрипте деплоя

#cache
cd cache
terraform destroy -auto-approve

#rds
cd ../rds
terraform destroy -auto-approve

#alb
cd ../alb
terraform destroy -auto-approve

#asg_instances
cd ../webservers
terraform destroy -auto-approve

#bastion
cd ../bastion
terraform destroy -auto-approve

#security_groups
cd ../security_groups
terraform destroy -auto-approve

#network
cd ../network
terraform destroy -auto-approve





#bucket
cd ../s3bucket
aws s3 rm s3://$tf_bucket_name --recursive
terraform destroy -auto-approve

cd ..
