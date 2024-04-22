#!/bin/bash

# Function: enter_ns
# Description: Enter the network namespace of a specified Kubernetes Pod
# Parameters:
#   $1: Pod name
#   $2: Namespace (default: "default")
# Output:
#   None

function enter_ns() {
    # Set exit options and error handling
    set -exu

    # Parameter validation and default value setting
    if [ $# -lt 1 ]; then
        echo "Error: At least one parameter (Pod name) is required."
        exit 1
    fi
    pod_name="$1"
    ns=${2-"default"}

    # Safely build the kubectl command to prevent command injection
    kubectl_cmd="kubectl -n $ns describe pod $pod_name"

    # Retrieve Pod info and extract container image ID
    if ! pod_info=$($kubectl_cmd); then
        echo "kubectl command failed: Check the namespace ($ns) and Pod name ($pod_name)."
        exit 1
    fi
    pod_container_id=$(echo "$pod_info" | grep -A10 "^Containers:" | grep -Eo 'containerd://.*$' | head -n 1 | sed 's/containerd:\/\/\(.*\)$/\1/')
    if [ -z "$pod_container_id" ]; then
        echo "Unable to find the Pod container ID."
        exit 1
    fi

    # Retrieve PID and check the execution status of crictl inspect
    cri_inspect_cmd=(crictl inspect --output json "$pod_container_id")
    if ! cri_json=$("${cri_inspect_cmd[@]}"); then
        echo "crictl inspect command failed; unable to retrieve container json."
        exit 1
    fi

    pid=$(echo "$cri_json" | jq -r '.info.pid')
    # Enter the network namespace
    echo "Entering pod netns for $ns/$pod_name"
    nsenter_cmd="nsenter -n --target $pid"
    echo "$nsenter_cmd"
    # Use eval safely to execute the command
    eval "$nsenter_cmd"
}

enter_ns "$1" "$2"