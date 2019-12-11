provider "kubernetes" {
  host                   = google_container_cluster.main.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.main.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_service" "example_service" {
  metadata {
    name = "example-service"
  }
  spec {
    selector = {
      app = "${kubernetes_pod.example_pod.metadata.0.labels.app}"
    }
    session_affinity = "ClientIP"
    port {
      port        = 8000
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "example_pod" {
  metadata {
    name = "example-pod"
    labels = {
      app = "my-app"
    }
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "example"
    }
  }
}
