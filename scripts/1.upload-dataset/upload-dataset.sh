#!/bin/bash
source_path="/pfs/deeplearning-training-images"
dataset_name="pachyderm-training-dataset"
ngc dataset upload --source ${source_path} ${dataset_name} -y
random_id=`hexdump -n 16 -v -e '/1 "%02X"' /dev/urandom`
cd /pfs/out; touch ${random_id}
