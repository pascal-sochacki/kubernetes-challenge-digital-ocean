Before we can build our GitOps CI/CD implementation we need a K8s Cluster. 
My goto is to use Terraform to provision a Kubernetes Cluster in a public cloud. 
To access DigitalOcean we need to have a DigitalOcean API Key.
This key can be found in the [DigitalOcean Control Panel](https://cloud.digitalocean.com/account/api/tokens).
Click `Genrate New Token`, type a name for the token and select `Read and Write` permissions.
Now Copy the Token and keep it safe :). 
To use the Token with Terraform we can define an environment variable (`DIGITALOCEAN_TOKEN`).
Now we can apply the Terraform configuration (`terraform apply`).

### Create

1) `export DIGITALOCEAN_TOKEN=<Token>`
2) `terraform apply`
3) visit [DigitalOcean](https://cloud.digitalocean.com/kubernetes/clusters) to download your config file for the new
   created Cluster
4) copy the config file to the `.kube` directory

* for macOS: `mv Downloads/kubernetes-cluster-kubeconfig.yaml ~/.kube/`

5) Get the Nodes with `cd ~/.kube && kubectl --kubeconfig="kubernetes-cluster-kubeconfig.yaml" get nodes`

### Destory

1) `terraform destroy`
