## GKE Cluster
This documention covers all the steps needed for running the project on a kubernetes cluster. For now, GKE cluster is assumed to be underlying K8S cluster.

- GKE Cluster
  - Create a Google Cloud Account
  - Select a Zone
  - Create a Project
  - Install Google Cloud SDK
  - Initialize Google Cloud SDK
  - Set kube config
  - IAM Roles for GKE
  - Enable Containers Engine
  - Create a Kubernetes Cluster
  - Service Account
  - Static IP
- Github Actions
  - Static IP
  - Service Account Key
- Ingress Controller
  - Install nginx ingress controller
  - Assign static IP
- Tools
  - Helm
  - NATS
  - Envoy
  - Minio

### Create a Google Cloud Account
First things first, go to https://cloud.google.com/ to sign up for a Google Cloud account if you do not already have one. If you already have an account, sign in, otherwise click ‘Get Started for Free’ and create a new account. Sign in and go to console Home.

### Select a Zone
A zone and a region must be selected for GKE cluster. You can use this documention for details:
[Regions and Zones](https://cloud.google.com/compute/docs/regions-zones).

No region/zone feature have used so you can just use the nearest one to your users or ```europe-west3-a``` for example.

```
export GKE_ZONE=europe-west3-a
export GKE_REGION=europe-west3
```

### Create a Project
If you do not have a project, click the drop down in the header toolbar and create a new project by clicking the ‘NEW PROJECT’ button.

Set your project name as an environment variable:
```
export GKE_PROJECT=getcouragenow
```

### Install Google Cloud SDK
To access your new GKE cluster from your client, you need to install the gclouc cli that is included in the Google Cloud SDK.

Go to https://cloud.google.com/sdk and follow the instructions to install the SDK on your client platform, e.g. click the button for ‘INSTALL FOR MACOS’ if your client is a Mac OSX.

### Initialize Google Cloud SDK

```$ gcloud init
Welcome! This command will take you through the configuration of gcloud.
Settings from your current configuration [default] are:
compute:
  region: europe-west3
  zone: europe-west3-a
core:
  account: winwisely000@gmail.com
  disable_usage_reporting: 'True' 
  project: getcouragenow
Pick configuration to use:
[1] Re-initialize this configuration [default] with new settings
[2] Create a new configuration
Please enter your numeric choice:
```
Update Google Clouds SDK components,
```
$ gcloud components update
```

### Set kube config
By default, kubectl looks for a file named ‘config’ in the ‘~/.kube’ directory to access the API server of a cluster.

The ‘gcloud auth login’ command, obtains access credentials via a web-based authorization flow and sets the configuration.

To authenticate with Google Cloud SDK,
```
$ gcloud auth login
```
A webpage will open, click the Allow button.

You can update an existing kube config file with the credentials of a specific cluster by running the following command,
```
$ gcloud container clusters get-credentials standard-cluster --zone $GKE_CLUSTER --project $GKE_ZONE
```

View your current-context,

```
$ kubectl config current-context
```

Your client is now connected to the remote cluster on GKE.