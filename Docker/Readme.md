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



## Docker Commands

- docker run nginx  : creates a container of the image specified (nginx in this case from docker hub) on docker host. This runs container in attached mode.
- docker run -d nginx   : crates a container in detached mode.
- docker pull nginx : just downloads the image from remote to the docker host.
- docker ps  : lists the containers available on docker host.
- docker stop <container id/name>   : stops a running container
- docker start <container id/name>  : starts a running container
- docker rm <container id/name>     : to remove/delete a stopped container
- docker images     : to see a list of avaialable images on docker host
- docker rmi <image id/tag>     : to remove/delete an image not using by any container.
- docker exec <container id/name> <command (cat, ls ...)>   : to execute a command / extract information on / from running container.
- docker inspect <container id/name>    : get all the details of a container.
- docker logs <container id/name>   : get logs from the container
- docker attach <container id/name> : get back to docker container prompt
- docker history <image name>   : get layer level details of the image.

## Docker Networking

- Bridge : Default network a container get attached to when its created. A private internal network created by docker on the host. IP addr usually is 172.17 series
- None : docker run ubuntu --network=none. Containers cannot be accessible to any external network or other containers. 
- Host : docker run ubuntu --network=host. This means you don't need to map ports when containers are run. containers can be accessed externally using port used in container with host's IP. Cannot run multiple containers using same port number.

- User defined networks: 

        docker network create \
            --driver bridge \
            --subnet 182.18.0.0/16 custom-isolated-network

## Docker Volumes:

- Bind Mounting : Mount a specific folder from the docker host to container.
- Volume Mounting : Mount a folder from /var/lib/docker/volumes directory to a docker container.

Attaching a volume to docker container.

     Old method: docker run -v /data/mqsql:/var/lib/mysql mysql
     New method: docker run \
                 --mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql

***Storage Drivers***

     AUFS
     ZFS
     BTRFS
     Device Mapper
     Overlay
     Overlay2

 Selecting drivers depends on underlaying docker host's OS.

     eg: for ubuntu default storage driver is AUFS where as Device Mapper for centos or fedora.

## Space consumed by docker resources

    - docker system df

        [root@localhost home]# docker system df
        TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
        Images          3         1         574.2MB   133.3MB (23%)
        Containers      1         1         169.6MB   0B (0%)
        Local Volumes   1         1         450.5MB   0B (0%)
        Build Cache     0         0         0B        0B

    - docker system df -v

        [root@localhost home]# docker system df -v
        Images space usage:

        REPOSITORY        TAG       IMAGE ID       CREATED       SIZE      SHARED SIZE   UNIQUE SIZE   CONTAINERS
        nginx             latest    f8f4ffc8092c   11 days ago   133.3MB   0B            133.3MB       0
        hello-world       latest    feb5d9fea6a5   2 weeks ago   13.26kB   0B            13.26kB       0
        jenkins/jenkins   lts       619aabbe0502   6 weeks ago   440.9MB   0B            440.9MB       1

        Containers space usage:

        CONTAINER ID   IMAGE                 COMMAND                  LOCAL VOLUMES   SIZE      CREATED       STATUS        NAMES
        3d1ff5431066   jenkins/jenkins:lts   "/sbin/tini -- /usr/…"   1               170MB     2 weeks ago   Up 46 hours   jenkins

        Local Volumes space usage:

        VOLUME NAME    LINKS     SIZE
        jenkins_home   1         450.5MB

        Build cache usage: 0B

        CACHE ID   CACHE TYPE   SIZE      CREATED   LAST USED   USAGE     SHARED
