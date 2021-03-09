#!/bin/bash

#bucket
cd s3bucket
if [ -z ${tf_bucket_name} ];
then
echo -n "Please enter bucket name for tf state: "
read bucket_name
export tf_bucket_name=`echo $bucket_name`
fi

sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' variables.tf
terraform init
terraform apply

#network
cd ../network
sed -i 's|DEFAULT_NAME|'"$bucket_name"'|' main.tf
terraform init
terraform apply


cd ..