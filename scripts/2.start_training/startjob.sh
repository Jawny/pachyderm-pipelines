#!/bin/bash
job_name="joliao-pachyderm-job"
training_dataset_id="107904"
validation_dataset_id="107905"
workspace_id="y9tpjrw0Sw6SCgPQ_-X4lA"
command_line="cd /mnt/workspace/mlops-training-to-deployment; python3 launchpad.py"

job_id=`ngc batch run --name ${job_name} --instance dgx1v.32g.4.norm --image "nvidia/tensorflow:22.07-tf2-py3" --datasetid ${training_dataset_id}:/mnt/data/training --datasetid ${validation_dataset_id}:/mnt/data/validation --workspace ${workspace_id}:/mnt/workspace:RW --commandline "${command_line}" --result /results | grep "Id:" | awk '{print $2}'`

touch /pfs/out/${job_id}

