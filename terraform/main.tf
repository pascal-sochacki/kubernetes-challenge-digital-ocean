resource "digitalocean_kubernetes_cluster" "main" {
  name    = "kubernetes-cluster"
  region  = "fra1"
  version = "1.21.5-do.0"
  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}
