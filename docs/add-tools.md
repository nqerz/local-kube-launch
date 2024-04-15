# How to add new tools

The project is planning to add new tools such as K3d or Minikubes, here is the steps to add a new tool.

## Steps

1. Create a new folder by the name of your tool:

   ```bash
   mkdir -p k3d
   ```

2. Add you configuration file under the folder.

3. Add a new Makefile under `scripts/make-rules` with the targets to build your tool, for example:

   ```makefile
   .PHONY: k3d/create k3d/delete k3d/list

   k3d/create: ## Create a k3d cluster with the given configs.
       @echo "Creating k3d cluster..."
       k3d cluster create $(CLUSTER_NAME) --config=k3d/cluster-config.yaml

   k3d/delete: ## Delete a k3d cluster.
       @echo "Deleting k3d cluster..."
       k3d cluster delete $(CLUSTER_NAME)

   k3d/list: ## List all k3d clusters.
       k3d cluster list
   ```

4. Include the Makefile in the root Makefile:
   ```makefile
   include scripts/make-rules/k3d.mk
   ```
5. Add usage Markdown to [documentation](./docs).

6. Update dependencies in the root README.md.
