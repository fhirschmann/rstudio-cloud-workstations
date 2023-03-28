FROM rocker/rstudio:latest

# See https://www.rocker-project.org/use/extending/
RUN install2.r --error --skipinstalled --ncpus -1 bigrquery reticulate

# Basic support for gcloud
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg curl python3-pip

# Install gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
	tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add -
RUN apt-get update -y && apt-get install -y google-cloud-cli
RUN pip3 install google-cloud-aiplatform

# Initialize the Cloud Workstation (need to initialize the /home volume if needed)
COPY init_workstation.sh /etc/cont-init.d/05_initworkstation
RUN chmod 755 /etc/cont-init.d/05_initworkstation

# Allow access to root
ENV ROOT=true

# Access control is done by Cloud Workstations
ENV DISABLE_AUTH=true

EXPOSE 80
