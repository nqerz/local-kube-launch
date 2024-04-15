# Launch a local Kubernetes cluster using KinD

## Usage

1. Clone the repository:

   ```shell
   git clone https://github.com/nqerz-CloudOps/local-kube-launch.git
   ```

2. Customize the cluster configuration in the `cluster-config.yaml` file according to your requirements.

3. Start the local Kubernetes cluster:

   ```shell
   make kind/create
   ```

   This command will create a KinD cluster based on the provided configuration.

4. Verify the cluster is running:

   ```shell
   make kind/info
   ```

   This command will display information about the running cluster.

5. You are now ready to start deploying and testing your applications on the local Kubernetes cluster.
