# Create a main VM, a master VM and X workers VM for a K8s cluster
# 
# Based on Thiago Melo (2022) - https://github.com/reiserfs/k8s
#

resource "google_compute_instance" "main" {
  name                      = "main1"
  machine_type              = "${var.main_instance_type}"
  zone                      = "${var.cluster_zone}"
  allow_stopping_for_update = true
  tags                      = ["main","docker","jenkins","sonarqube", "ssh-enabled"]

  boot_disk {
    initialize_params {
      image = "${var.main_machine_image}"
    }
  }

  network_interface {
    subnetwork = "k8s-nodes"
    network_ip = "${var.prefix_netip}.2"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${file("${var.ssh_credentials}")}"
  }

  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  depends_on = [
    google_compute_subnetwork.k8s-nodes
  ]
}

resource "google_compute_instance" "master" {
  name                      = "k8s-master"
  machine_type              = "${var.cluster_instance_type}"
  zone                      = "${var.cluster_zone}"
  allow_stopping_for_update = true
  tags                      = ["k8s-cluster","master-node","controller", "ssh-enabled"]

  boot_disk {
    initialize_params {
      image = "${var.cluster_machine_image}"
    }
  }

  network_interface {
    subnetwork = "k8s-nodes"
    network_ip = "${var.prefix_netip}.10"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${file("${var.ssh_credentials}")}"
  }

  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  depends_on = [
    google_compute_subnetwork.k8s-nodes
  ]
}

resource "google_compute_instance" "workers" {
  name         = "k8s-worker${count.index}"
  machine_type = "${var.cluster_instance_type}"
  zone = "${var.cluster_zone}"
  allow_stopping_for_update = true
  count = var.k8s_workers

  tags = ["k8s-cluster","master-node","controller", "ssh-enabled"]

  boot_disk {
    initialize_params {
      image = "${var.cluster_machine_image}"
    }
  }

  network_interface {
    subnetwork = "k8s-nodes"
    network_ip = "${var.prefix_netip}.1${count.index+1}"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_username}:${file("${var.ssh_credentials}")}"
  }

  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  depends_on = [
    google_compute_subnetwork.k8s-nodes
  ]
}
