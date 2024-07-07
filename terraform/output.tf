output "main_ip" {
  value = google_compute_instance.main.network_interface[0].access_config[0].nat_ip
}

output "k8s_cluster_info" {
  value = {
    master_ip  = google_compute_instance.master.network_interface[0].access_config[0].nat_ip
    worker1_ip = google_compute_instance.workers[0].network_interface[0].access_config[0].nat_ip
    worker2_ip = google_compute_instance.workers[1].network_interface[0].access_config[0].nat_ip
    worker3_ip = google_compute_instance.workers[2].network_interface[0].access_config[0].nat_ip
  }
}