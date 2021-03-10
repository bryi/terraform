#!/bin/bash

#порядок ресурсов обратен порядку в скрипте деплоя

#bastion
cd bastion
terraform destroy

#security_groups
cd ../security_groups
terraform destroy

#network
cd ../network
terraform destroy





#bucket
cd ../s3bucket
aws s3 rm s3://$tf_bucket_name --recursive
terraform destroy

cd ..
