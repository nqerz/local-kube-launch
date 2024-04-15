# local-kube-launch

**local-kube-launch** is a solution for developers to easily start a local Kubernetes cluster based on KinD, with plans to support additional tools like k3d or minikube for creating local Kubernetes development and experimentation environments.

This project aims to simplify the setup and configuration process by providing a comprehensive cluster config YAML file and a Makefile. By leveraging the power of KinD and other compatible tools, developers can quickly spin up a Kubernetes cluster on their local machines for development, testing, and learning purposes.

## Features

- **Easy deployment**: Simply clone the repository, customize the cluster configuration in the YAML file, and run a few commands with the help of the Makefile.
- **Extensibility**: Designed to support future integration with other local Kubernetes environment tools such as k3d or minikube, providing developers with options for their specific needs.
- **Developer-friendly**: Provides a hassle-free way to set up a local Kubernetes environment, enabling developers to focus on application development and testing without worrying about complex infrastructure setup.

## Dependencies

- [KinD](https://kind.sigs.k8s.io/): KinD (Kubernetes in Docker) is used as the primary tool for creating local Kubernetes clusters.
- [Make](https://www.gnu.org/software/make/): Make is used to provide a simple and consistent interface for running commands and managing the project.

## Usage

Let's take a look at the basic KinD cluster usage steps:

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

For more details and advanced usage instructions, please refer to the [documentation](./docs).

## Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](./LICENSE).
