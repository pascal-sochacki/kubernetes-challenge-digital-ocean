# Create

1) `export DIGITALOCEAN_TOKEN=<Token>`
2) `terraform apply`
3) visit [DigitalOcean](https://cloud.digitalocean.com/kubernetes/clusters) to download your config file for the new
   created Cluster
4) copy the config file to the `.kube` directory

* for macOS: `mv Downloads/kubernetes-cluster-kubeconfig.yaml ~/.kube/`

5) Get the Nodes with `cd ~/.kube && kubectl --kubeconfig="kubernetes-cluster-kubeconfig.yaml" get nodes`

# Destory

1) `terraform destroy`
