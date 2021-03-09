#!/bin/bash

#network
cd network
terraform destroy




#bucket
cd ../s3bucket
aws s3 rm s3://$tf_bucket_name --recursive
terraform destroy

cd ..
