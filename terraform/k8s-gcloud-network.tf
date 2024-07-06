# Create a main VM, a master VM and X workers VM for a K8s cluster
# 
# Based on Thiago Melo (2022) - https://github.com/reiserfs/k8s
#

resource "google_compute_network" "k8s-cluster" {
  name         = "${var.k8s_cluster_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "k8s-nodes" {
  name          = "${var.k8s_nodes_name}"
  ip_cidr_range = "${var.subnet}"
  network       = "k8s-cluster"
  depends_on    = [
    google_compute_network.k8s-cluster
  ]
}

output "public_ip" {
  value = google_compute_instance.master.network_interface[0].access_config[0].nat_ip
}
