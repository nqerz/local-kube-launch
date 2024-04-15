LOCAL_K8S_TOOL ?=kind

# Cluster name
CLUSTER_NAME ?= local-kube-launch

# Cluster name with suffix
CLUSTER_NAME_SUFFIX_ENABLE ?= false

# Add variable flag CLUSTER_NAME_SUFFIX_ENABLE true/false to enable 6 random suffix for CLUSTER_NAME to avoid name conflict
ifeq ($(CLUSTER_NAME_SUFFIX_ENABLE),true)
CLUSTER_NAME := $(CLUSTER_NAME)-$(shell head /dev/urandom | tr -dc a-z0-9 | head -c 6)
else
CLUSTER_NAME := $(CLUSTER_NAME)
endif

# include the common make file
COMMON_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

ifeq ($(origin ROOT_DIR),undefined)
ROOT_DIR := $(abspath $(shell cd $(COMMON_SELF_DIR)/../.. && pwd -P))
endif

SCRIPTS_DIR=$(ROOT_DIR)/scripts