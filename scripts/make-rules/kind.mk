CLUSTER_CONFIGFILE :=kind/cluster-config
KIND_CLUSTER_CONTEXT_NAME := $(LOCAL_K8S_TOOL)-$(CLUSTER_NAME)

.PHONY: kind/create kind/delete kind/list

##@ Kind Cluster Management
kind/create: ## Create a kind cluster with istio extra port mappings.
	@echo "Creating kubernetes cluster name: $(CLUSTER_NAME), config file: $(CLUSTER_CONFIGFILE)"
	@kind create cluster --name=$(CLUSTER_NAME) --config=$(CLUSTER_CONFIGFILE).yaml
	kind get kubeconfig --name=$(CLUSTER_NAME) > $(HOME)/.kube/$(LOCAL_K8S_TOOL)-config

kind/delete: ## Delete a kind cluster with the given configs.
	@echo "Deleting kubernetes cluster name: $(CLUSTER_NAME)"
	kind delete cluster --name=$(CLUSTER_NAME)

kind/list: ## List all kind clusters.
	@kind get clusters

kind/info: ## Verify the cluster is running.
	@kubectl cluster-info --context $(KIND_CLUSTER_CONTEXT_NAME)

##@ Kube IDE
kube/ide: ## Launch a IDE with the given configs.
	k9s --kubeconfig $(HOME)/.kube/$(LOCAL_K8S_TOOL)-config
