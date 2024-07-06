# Create a main VM, a master VM and X workers VM for a K8s cluster
# 
# Based on Thiago Melo (2022) - https://github.com/reiserfs/k8s
#

provider "google" {
  project = "${var.project_name}"
  region  = "${var.cluster_region}"
  zone    = "${var.cluster_zone}"
  credentials = file("gcloud.json")
}
