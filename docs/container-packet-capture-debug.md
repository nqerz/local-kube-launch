# Capture Packets in a Container

This guide will show you how to capture packets in a container using `containerd` or `docker`.

## Docker

1. Shrink replicas to 1 if you have more than one replica.
2. Get the container ID:

   ```bash
   kubectl -n <namespace> describe pod <pod-name> | grep -A10 "^Containers:" | grep -Eo 'docker://.*$' | head -n 1 | sed 's/docker:\/\/\(.*\)$/\1/'
   ```

3. Get the process ID of the container:

   ```bash
   docker inspect -f {{.State.Pid}} <container>
   ```

   Replace `<container id>` with the ID of your container.

4. Enter the network namespace of the container:

   ```bash
   nsenter -n -t <pid>
   ```

5. Now you are in the network namespace of the container. You can use `ss -tunlp` to check the network connections:

   ```bash
   ss -tunlp
   ```

6. If you want to capture packets, you can use `tcpdump`. For example, to capture all TCP packets on port 80:

   ```bash
   tcpdump -i any tcp port 80 -w /tmp/capture.pcap
   ```

   This will save the captured packets to `/tmp/capture.pcap`.

7. To exit the network namespace, simply type `exit`.

## Containerd

1. Shrink replicas to 1 if you have more than one replica.
2. Get the container ID:
   ```bash
   kubectl -n <namespace> describe pod <pod-name> | grep -A10 "^Containers:" | grep -Eo 'containerd://.*$' | head -n 1 | sed 's/containerd:\/\/\(.*\)$/\1/'
   ```
3. Get the process ID of the container:

   ```bash
   crictl inspect --output json <container> | jq -r '.info.pid'
   ```

   Replace `<container id>` with the ID of your container.

4. Enter the network namespace of the container:

   ```bash
   nsenter -n -t <pid>
   ```

   Replace `<pid>` with the process ID obtained in the previous step.

5. Now you are in the network namespace of the container. You can use `ss -tunlp` to check the network connections:

   ```bash
   ss -tunlp
   ```

6. If you want to capture packets, you can use `tcpdump`. For example, to capture all TCP packets on port 80:

   ```bash
   tcpdump -i any tcp port 80 -w /tmp/capture.pcap
   ```

   This will save the captured packets to `/tmp/capture.pcap`.

7. To exit the network namespace, simply type `exit`.

Please note that you need the appropriate permissions to execute these commands.

This guide assumes that you have already set up a Kubernetes cluster and have access to the `kubectl` command-line tool. If you don't have a Kubernetes cluster, you can follow the instructions in the [Kubernetes documentation](https://kubernetes.io/docs/setup/) to set up a cluster.

# Test in a KinD Cluster

1. Copy the `kind-config.yaml` file to your local machine.
2. Copy the scripts into KinD nodes:
   ```bash
   docker cp ./scripts/troubleshooting/network/contianerd-enterns.sh <kind-cluster-node-name>:/tmp
   ```
3. Log into the KinD node:
   ```bash
   docker exec -it -w /tmp <kind-cluster-node-name> sh
   ```
4. Run the script:
   ```bash
   ./contianerd-enterns.sh <pod-name> <namespace>
   ```
