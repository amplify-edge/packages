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


# Test golang client/serveur liftbridge

1. start nats server: `make nats`
2. start liftbridge server: `make lift`
3. start server: `make svr-go`
4. start a go-client: `make cli-go`

You can run many clients in different shells to test with.

# Setup local to run nats and jetstream
1. run `make config-nats-jets`   
2. run `start-jets` to start server
3. in another shell run `make build-cli`
4. jets --help

# create a stream in jetstream using CLI jets
1. To create a stream in jetstream run: `jets stream -n MESSAGES -s MESSAGES.* -g file`
2. now to publish run: `jets publish -s MESSAGES.messages -t Hello world`
for now fake data should be list of strings
3. to publish fake data from file run `jets faker -f ./fake_data/data.json`
4. to publish fake data from url run `jets faker -u http://www.example.com`
5. to see details about a stream run `jets stream ls`
