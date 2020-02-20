# Server for main template
# GCP
Set up secrets in your workspace: GKE_PROJECT with the name of the project, GKE_EMAIL with the service account email, GKE_KEY with the Base64 encoded JSON service account key (https://github.com/GoogleCloudPlatform/github-actions/tree/docs/service-account-key/setup-gcloud#inputs).
Afteer deployment use kubectl port-forward:

# Minikube
Install minikube and then run below command:
```
make deploy
```

# Client connection
You can connect your flutter client to this server via:

For web:
```
make connect-grpc-web
```

For others:
```
make connect-grpc
```

And for android use adb to connect local port to emulator:
```
adb reverse tcp:9074 tcp:9074
```