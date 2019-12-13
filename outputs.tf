output "cluster_ca_certificate" {
  value = google_container_cluster.main.master_auth.0.cluster_ca_certificate
}

output "cluster_name" {
  value = google_container_cluster.main.name
}

output "ingress_ip" {
  value = kubernetes_ingress.example_ingress.load_balancer_ingress.0.ip
}