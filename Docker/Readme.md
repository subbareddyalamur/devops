# Install Docker dependencies

    sudo apt-get update

    sudo apt-get install \\\
       apt-transport-https \\\
       ca-certificates \\\
       curl \\\
       gnupg \\\
       lsb-release

# Add Docker’s official GPG key:

     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
     
# Install Docker:

    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    
# For different version of docker:

    sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
    
# Instal Docker Compose:

    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    
# Uninstall Docker:
To completely uninstall Docker:

## Step 1

    dpkg -l | grep -i docker
    
To identify what installed package you have:
## Step 2

    sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
    sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
    
The above commands will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following commands:

    sudo rm -rf /var/lib/docker /etc/docker
    sudo rm /etc/apparmor.d/docker
    sudo groupdel docker
    sudo rm -rf /var/run/docker.sock
    
You have removed Docker from the system completely.


# Docker commands

## Create image from existing container

    docker ps -a
    docker commit <running contianer name> <tag for new image>
    docker commit tf subbareddyalamur/terraform:1.0.0
    docker images
    docker login
    docker push <new image:tab>
    docker push subbareddyalamur/terraform:1.0.0
    
## create windows volume and attach to linux container
#### Run the cmd in powershell. ${pwd} = present working dir.

    docker run -dit --name terraform -v "${pwd}:/home/terraform" subbareddyalamur/terraform:1.0.0
    
## Commit container changes to an image and push to docker hub

    # docker commit <container name> <tag>
    docker commit jenkins subbareddyalamur/jenkins:latest
    
    # push to docker hub
    docker push subbareddyalamur/jenkins:latest
    
## Build image with Dockerfile

*************************************************

    # Docker file example: The image is built on ubuntu with gcloud sdk and terraform installed.
    
    FROM ubuntu
    LABEL  maintainer="subbareddyalamur@gmail.com"
    RUN apt-get update && \
        apt-get install -y curl gnupg2
    # install gcloud sdk
    RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && \
        apt-get update -y && apt-get install google-cloud-sdk -y
    # install terraform
    RUN apt-get install -y software-properties-common && \
        curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
        apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
        apt-get update && apt-get install -y terraform

**************************************************

    # Build image and tag
    docker build -t <repo:tag> .
    
    eg: docker build -t subbareddyalamur/terraform:1.0.2 .
