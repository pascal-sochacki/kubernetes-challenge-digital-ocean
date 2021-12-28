# Deploy a GitOps CI/CD implementation

Hey, in this guide we will deploy a GitOps CI/CD implementation, using Argocd, Terraform, Tekton and Helm. The aim is to
deploy a simple application each time a new commit is pushed to the repository.

### Prerequisites

kubectl 

helm 

terraform 

tekton

## Create a Kubernetes cluster

First, we will create a Kubernetes cluster in DigitalOcean. My goto is to use Terraform for this. First, we need to
authenticate with DigitalOcean. This could be
done [multiple ways](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs), but I will use an
environment variable(`DIGITALOCEAN_TOKEN`). To retrieve a token, go
to [DigitalOcean](https://cloud.digitalocean.com/account/api/tokens) and create a new token. Now export the token to an
environment variable.

```
export DIGITALOCEAN_TOKEN=<your token>
```

With the token in hand, we can run

```
cd terraform
terraform init
terraform apply
```

This will create a Kubernetes cluster in DigitalOcean. The `main.tf` file contains the following:

```
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
```

We can see i created a cluster named `kubernetes-cluster` in the `fra1` region. The cluster contains a `worker-pool`
node pool with 2 nodes. This could take a while, so we will wait for the cluster to be ready. In the meantime, we can
configure the `kubectl` context. We need to download the configuration file from the cluster
from [DigitalOcean](https://cloud.digitalocean.com/kubernetes/clusters). After downloading the file, we can set the
context.

```
export KUBECONFIG=<path to the downloaded file>
```

After about 4-5 minutes, we can run `kubectl get nodes` and see the nodes. If everything is working, we should see the
following:

```
NAME                STATUS   ROLES    AGE   VERSION
worker-pool-u6f28   Ready    <none>   31h   v1.21.5
worker-pool-u6f2u   Ready    <none>   31h   v1.21.5
```

Congratulations, you have created a Kubernetes cluster in DigitalOcean.

## Configure the Cluster to run Argocd and Tekton

To install Argocd i used the Argocd Helm chart. To follow the installation guide, we will use the `helm` command. 
```shell
cd infra
helm dep up
helm install infra infra
```
This should install Argocd. To check if it is installed, we can run
```
kubectl get pods
```
We should see something like this:
```
NAME                                                   READY   STATUS    RESTARTS   AGE
infra-argocd-application-controller-6cd84b6ff9-r4pbz   1/1     Running   0          7h20m
infra-argocd-dex-server-66896fbf7d-wbhzb               1/1     Running   0          7h20m
infra-argocd-redis-5457bddfd8-lj7dx                    1/1     Running   0          7h20m
infra-argocd-repo-server-6865dfb9cd-gv8xm              1/1     Running   0          7h20m
infra-argocd-server-ffd7f79c9-x8jnq                    1/1     Running   0          7h20m
```
To visit the dashboard, we can forword the port 8080 to the host machine.
```
kubectl port-forward svc/infra-argocd-server 8080:80
```
Now we can visit the dashboard at http://localhost:8080. 
The default username is `admin` and the default password is a little tricky.
We need to use the `kubectl` command to get the password.
```
kubectl get secrets argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d | pbcopy
```
The password is now in the clipboard. Paste it in the browser.

