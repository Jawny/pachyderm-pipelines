#!/bin/bash
# grep job_id in previous job and save into job_id and then in this job grab that file and read.

#job_id=`cd /pfs/start-training; ls -Art |tail -n 1`
job_id=3308888
job_name="joliao"
running_jobs=`ngc batch list | grep -e QUEUED -e STARTING -e RUNNING | grep ${job_name} | awk '{print $2}'`
echo ${running_jobs}
while [ 1 ]
do
        running_jobs_array=()
        echo working

        for job in $running_jobs; do
                running_jobs_array+=($job)
                echo ${job}
        done

        echo ${running_jobs_array}
        if [ -z "${running_jobs_array}" ]
        then
                break
        else
                sleep 10m
        fi
done



ngc result download ${job_id}

model_name="pachyderm_model"
source_path="./${job_id}"

curr_version=`ngc registry model info egxdefault/pachyderm_model | grep "Latest Version ID:" | awk '{print $4}' | tr -dc '0-9'`

ngc registry model upload-version egxdefault/${model_name}:v$((++curr_version)) --source ${source_path} > out 2>ngc-upload.log
upload_result=`grep "Error:" ngc-upload.log`

if grep -R "Error:" ngc-upload.log
then
    ngc registry model create egxdefault/${model_name} --application joliao-demo-app --framework tensorflow2 --format SavedModel --precision FP32 --short-desc "demo"
    ngc registry model upload-version egxdefault/${model_name}:v1 --source ${source_path}
else
    echo "pass"
fi
