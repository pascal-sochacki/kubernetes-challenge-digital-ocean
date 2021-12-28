## Code for the [DigitalOcean Kubernetes Challenge](https://www.digitalocean.com/community/pages/kubernetes-challenge) 

### The Challenge picked: Deploy a GitOps CI/CD implementation

Description:
GitOps is today the way you automate deployment pipelines within Kubernetes itself, and ArgoCD  is currently one of the leading implementations. Install it to create a CI/CD solution, using tekton and kaniko for actual image building. https://medium.com/dzerolabs/using-tekton-and-argocd-to-set-up-a-kubernetes-native-build-release-pipeline-cf4f4d9972b0

#### Code Repository

https://github.com/pascal-sochacki/kubernetes-challenge-digital-ocean-app


#### Let's see how this goes:

`Log[0]:` Create a Terraform file(s) for my Kubernetes cluster in DigitalOcean.

`Log[1]:` Install ArgoCD, Harbor and Tekton. Create an ArgoCD sync for pipeline resources

`Log[2]:` Create a GitOps CI/CD pipeline using ArgoCD and Tekton. Build the docker image using kaniko.

`Log[3]:` Push the image to Harbor. Or use the DigitalOcean Registry. 

#### Gotchas:

Well it turns out that ArgoCD wants to manage all(?) resources in the namespace. 
So ArgoCD deleted my TaskRuns and PipelineRuns. I thought this was a tekton issue, but it's not.
This took me a while to figure out (2-3h). 
I found a [Github issue](https://github.com/tektoncd/pipeline/issues/3202) and a [useful answer](https://github.com/tektoncd/pipeline/issues/3202#issuecomment-718802883), which I followed and it works.
The fix is to configure the default ArgoCD Project (or the Project you use) to ignore some resources.
see `argocd/defaultProject.yaml`
