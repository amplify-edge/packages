# Server for main template
Set up secrets in your workspace: GKE_PROJECT with the name of the project, GKE_EMAIL with the service account email, GKE_KEY with the Base64 encoded JSON service account key (https://github.com/GoogleCloudPlatform/github-actions/tree/docs/service-account-key/setup-gcloud#inputs).
Afteer deployment use kubectl port-forward:

For web:
```
kubectl port-forward svc/envoy 8074:443
```

For others:
```
kubectl port-forward svc/grpc-web 9074:9074
```

And for android use adb to connect local port to emulator:
```
adb reverse tcp:9074 tcp:9074
```