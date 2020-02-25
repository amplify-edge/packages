## Server for main template
### GCP
Install gcloud and Enable Kubernetes Engine API for your GCP project.
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
```