#!/bin/bash
job_name="joliao-pachyderm-training-validation"
dataset_id="104640"
workspace_id="aym045RkRcef8vvv72ru9A"
/ngc-cli/ngc batch run --name ${job_name} --instance dgx1v.32g.4.norm --image "nvidia/pytorch:22.05-py3" --datasetid ${dataset_id}:/mnt/data --workspace ${workspace_id}:/mnt/workspace:RW --commandline "cd /mnt/workspace/DeepLearningExamples/PyTorch/Classification/ConvNets; pip install 'git+https://github.com/NVIDIA/dllogger'; python3 main.py /mnt/data/ --workspace /results --no-checkpoints --evaluate > /results/validation.json" --result /results
