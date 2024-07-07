output "main_ip" {
  value = google_compute_instance.main.network_interface[0].access_config[0].nat_ip
}

output "k8s_cluster_info" {
  value = {
    master_ip   = google_compute_instance.master.network_interface[0].access_config[0].nat_ip
    worker_ips  = google_container_node_pool.k8s_workers.*.instance_group_urls
  }
}