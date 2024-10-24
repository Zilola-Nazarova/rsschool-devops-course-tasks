#!/usr/bin/env bash

set -e -o pipefail

export TF_OUTPUT="$(cd .. &&  terraform output -json)"
export CLUSTER_NAME="$(echo ${TF_OUTPUT} | jq -r .k8s_cluster_name.value)"
export STATE="s3://$(echo ${TF_OUTPUT} | jq -r .kops_s3_bucket.value)"

cd k8s-cluster
echo "${TF_OUTPUT}" > tf_output.json
kops toolbox template --name ${CLUSTER_NAME} --values tf_output.json --template cluster-template.yaml > cluster.yaml
kops replace -f cluster.yaml --state ${STATE} --name ${CLUSTER_NAME} --force
kops update cluster --target terraform --state ${STATE} --name ${CLUSTER_NAME} --out .