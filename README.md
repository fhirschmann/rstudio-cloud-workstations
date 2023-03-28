# RStudio on Google Cloud Workstations

This repository contains artifacts to deploy the [free version of RStudio Server](https://posit.co/download/rstudio-server/) to [Google Cloud Workstations](https://cloud.google.com/workstations).

Please follow these steps to create a Cloud Workstation for RStudio:

## Build container image

Define variables:
```bash
PROJECT_ID=$(gcloud config get-value project)
REGION="us-central1"
REPO_NAME="rstudio-cloud-workstations"
IMAGE_NAME="rstudio-cloud-workstations"
IMAGE_URI="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:latest
```

Create a repository that holds your container image.

```bash
gcloud artifacts repositories create $REPO_NAME --repository-format=docker --location=$REGION
```

Use [Cloud Build](https://cloud.google.com/build) to build the container image and upload it to the repository:

```bash
gcloud builds submit --region=$REGION --tag=$IMAGE_URI
```

Your container image is now available at the following URI:
```
echo $IMAGE_URI
```
