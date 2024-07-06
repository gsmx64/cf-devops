# Create a main VM, a master VM and X workers VM for a K8s cluster
# 
# Based on Thiago Melo (2022) - https://github.com/reiserfs/k8s
#

variable "project_name" {
  type    = string
  default = "k8s-devops-cf"
}

variable "cluster_region" {
  type    = string
  default = "us-east1"
}

variable "cluster_zone" {
  type    = string
  default = "us-east1-b"
}

variable "cluster_instance_type" {
  type    = string
  default = "e2-medium"
}

variable "cluster_machine_image" {
  type    = string
  default = "rocky-linux-cloud/rocky-linux-8-optimized-gcp"
}

variable "main_instance_type" {
  type    = string
  default = "e2-medium"
}

variable "main_machine_image" {
  type    = string
  default = "rocky-linux-cloud/rocky-linux-8-optimized-gcp"
}

variable "ssh_username" {
  type    = string
  default = "gsmcfdevops"
}

variable "prefix_netip" {
  type = string
  default = "192.168.87"
}

variable "subnet" {
  type = string
  default = "192.168.87.0/24"
}

variable "k8s_cluster_name" {
  type    = string
  default = "k8s-cluster"
}

variable "k8s_nodes_name" {
  type    = string
  default = "k8s-nodes"
}

variable "k8s_workers" {
  type    = number
  default = 3
}


