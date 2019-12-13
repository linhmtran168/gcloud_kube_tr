data "google_client_config" "current" {}
provider "kubernetes" {
  load_config_file       = false
  host                   = google_container_cluster.main.endpoint
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.main.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_ingress" "example_ingress" {
  metadata {
    name = "example-ingress"
  }

  spec {
    backend {
      service_name = kubernetes_service.example_service.metadata.0.name
      service_port = kubernetes_service.example_service.spec.0.port.0.port
    }
  }
}

resource "kubernetes_service" "example_service" {
  metadata {
    name = "example-service"
  }
  spec {
    selector = {
      app = kubernetes_pod.example_pod.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 8000
      target_port = 80
    }

    type = "NodePort"
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
