# Server for main template

# GCP
Set up secrets in your workspace: GKE_PROJECT with the name of the project, GKE_EMAIL with the service account email, GKE_KEY with the Base64 encoded JSON service account key (https://github.com/GoogleCloudPlatform/github-actions/tree/docs/service-account-key/setup-gcloud#inputs).
Afteer deployment use kubectl port-forward:

# Minikube
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