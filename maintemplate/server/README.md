
## Server for main template

Install the gcloud tool:

- windows: https://cloud.google.com/sdk/docs/quickstart-windows
- mac: https://cloud.google.com/sdk/docs/quickstart-macos
- linux: https://cloud.google.com/sdk/docs/quickstart-linux


### GCP
Enable Kubernetes Engine API for your GCP project.
```
GCP_USER=<your GCP username> GCP_PROJECT=<your GCP project> make gke-setup
```
Then run this command to create your cluster:
```
GCP_USER=<your GCP username> GCP_PROJECT=<your GCP project> make gke-create
```
If you want to specify GCP zone and region, you can provide them as environment variables too:
```
GCP_ZONE=<GCP zone> GCP_REGION=<GCP region> GCP_USER=<your GCP username> GCP_PROJECT=<your GCP project> make gke-setup
```
Now you can get github action variables for your cluster:
```
GCP_USER=<your GCP username> GCP_PROJECT=<your GCP project> make gke-vars
```
or if you have specified zone and region:
```
GCP_ZONE=<GCP zone> GCP_REGION=<GCP region> GCP_USER=<your GCP username> GCP_PROJECT=<your GCP project> make gke-vars
```
Add provided variables as secrets to your github project. Github action will use these variables to deploy your project on GKE cluster and your project will be available on GKE_IP.


# Server for main template

http://34.89.133.90/#/

# GCP
Set up secrets in your workspace: GKE_PROJECT with the name of the project, GKE_EMAIL with the service account email, GKE_KEY with the Base64 encoded JSON service account key (https://github.com/GoogleCloudPlatform/github-actions/tree/docs/service-account-key/setup-gcloud#inputs).
Afteer deployment use kubectl port-forward:


### Minikube
Install minikube and then run below command:
```
eval $(minikube docker-env)
```
and:
```
make deploy
```
Flutter web will be served on minikube IP:
```
minikube ip

