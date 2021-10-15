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
- docker image save alpine:latest -o alpine.tar  : save image locally
- docker image load -i alpine.tar  :  load image from local dir.
- docker rmi <image id/tag>     : to remove/delete an image not using by any container.
- docker exec <container id/name> <command (cat, ls ...)>   : to execute a command / extract information on / from running container.
- docker inspect <container id/name>    : get all the details of a container.
- docker logs <container id/name>   : get logs from the container
- docker attach <container id/name> : get back to docker container prompt
- docker history <image name>   : get layer level details of the image.

**Import & Export operations**

    docker export <container-name> > test-container.tar
    docker image import test-container.tar newimage:latest

## Docker Networking

- Bridge : Default network a container get attached to when its created. A private internal network created by docker on the host. IP addr usually is 172.17 series
- None : docker run ubuntu --network=none. Containers cannot be accessible to any external network or other containers. 
- Host : docker run ubuntu --network=host. This means you don't need to map ports when containers are run. containers can be accessed externally using port used in container with host's IP. Cannot run multiple containers using same port number.

- User defined networks: 

        docker network create \
            --driver bridge \
            --subnet 182.18.0.0/16 custom-isolated-network

  **NameSpaces**

        # create network namespaces (red and blue) in a linux machine.
        ip netns add red
        ip netns add blue  
        # list namespaces
        ip netns
        # To list interfaces on the namespaces.
        ip netns exec red ip link  (or)
        ip -n red link 
        
        # to create a peering
        ip link add veth-red type veth peer name veth-blue
        # attach the peering to each namespace
        ip link set veth-red netns red
        ip link set veth-blue netns blue
        # set ip address to each namespace
        ip -n red addr add 192.168.15.1 dev veth-red
        ip -n blue addr add 192.168.15.2 dev veth-blue
        # bring the networks up.
        ip -n red link set veth-red up
        ip -n blue link set veth-blue up
        # try ping blue from red
        ip netns exec red ping 192.168.15.2


**Embedded DNS**

   Docker has a built in DNS thats runs at 127.0.0.11 which resolves container names to its IP addresses.

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

**Space consumed by docker resources**

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

## Docker Compose

    docker-compose up

## Docker Swarm

    Swarm Manager and Worker nodes

    - docker swarm init : will initialize swarm cluster on master/manager node and give token to join worker nodes to the swarm cluster.
    - docker swarm init --force-new-cluster : to bring the dead cluster up.
  
  If the host has multiple IP address specify --advertise-addr option to set the IP address to use.
  - docker swarm init --advertise-addr <ip>
 
    - docker swarm join --token <token> : Run this command on each worker node to join the node to swarm cluster.
    - docker swarm leave    : To remove a node from swarm cluster but the node name with status "down" will still appear in the cluster.
    - docker node rm <node-name/node-id>  : to completely remove the node from cluster.
    - docker node promote   :  To promote an existing worker node to a swam manager. This has to be run on master.
    - docker node update --availability drain <node>  : Make swam manager only perform management tasks and not serve as a worker node.

    - docker swarm join-token manager  : to get the token for another master join the swam cluster.


  **RAFT - Distributed Consensus algorithm**

     This decides who can be the leader among Swarm managers.
     
     It uses random timers for initializing a request. Eg: a random timer is kicked off on the 3 managers.
     The first one to finish the timers sends out a request to other managers requesting permission to be the leader. The other managers on receiving the request respond with their vote and node assumes the leader role. Now that it is elected leader it sends out notification at regular intervals to other master nodes informing them that it is continuing to assume leader role. In case the other nodes do not receive a notification from the leader at some point in time which could either be due to the leader going down or loosing network connectivity, the nodes initiate a re-election process among themselves and a new leader is identified. 
     
     Every manager has a copy of RAFT database that stores the information about the entire cluster and its important that they are all in sync. 

## Docker Service

    - docker service ls   :  To see the list of services in swarm.
    - docker service inspect <service>  : Disply detailed info on one or more services.
    - docker service logs <service>  : Fetch logs of a service or task.
    - docker service ps <service>  : lists the task of one or more services.
    - docker service rm <service>   : Remove one or more services.
    - docker service scale <service>  : scale one or multiple replicated services.
    - docker service create --replicas=3 <image>    : create containers in 3 node swarm cluster. Should be run in master node.
    - docker service create --mode global <my-monitoring-agent>  : create instance in each node on a swarm cluster.

    use case:
    let say we have 3 replicas in a 4 node swarm, and the requirement is to have replicas in all 4 modes.
    - docker service create --replicas=3 --name web-server my-web-server
    - docker service update --replicas=4 web-server
    - docker service update <service> --publish-add 5000:80  : to publish a port

  **Overlay Networking**

   In order for the containers in a swarm cluster to communicate with each other, we need to create an overlay network and attach it when creating the service.

    - docker network create --driver overlay --subnet 10.0.9.0/24 my-overlay-network
    - docker service create --replicas 2 --network my-overlay-network nginx

  **Ingress Network**

   When you create a docker swarm, ingress network will be created automatically. It has a builtin load balancer that redirects traffic from the published port to all the mapped ports on each container. No extra configuration has to be done.

## Docker Stacks

 Container : A packaged form of an application that has its own dependencies and runs in its own environment.
 Service  : A service is one or more instances of the same type of container that runs on a single node or across multiple nodes in a swarm cluster.
 Stack  : A stack is a group of inter releated services that together form an entire application. 

 Example docker stack file: docker-stack.yml

    version: "3"
    services:
        redis:
            image: redis
            resources:
                limits:
                    cpus: 0.01
                    memory: 50M
        db:
            image: postgres:9.4
            deploy:
                placement:
                    constraints:
                        - node.hostname == node1
                        - node.role == manager
        vote:
            image: dockersamples/examplevotingapp_vote
            ports:
                - 5000:80
            deploy:
                replicas: 2
        worker:
            image: dockersamples/examplevotingapp_worker
        result:
            image: dockersamples/examplevotingapp_result
            ports:
                - 5001:80

 Deploing docker stack

     docker stack deploy voting-app-stack --compose-file docker-stack.yml
     docker service ls
     docker service ps <service name>

     # To deploy the updated stack run the same stack deploy command.
     docker stack deploy voting-app-stack --compose-file docker-stack.yml

 **Docker Visualizer**

  To see the visual view of docker swarm.

    docker run -it -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock dockersamples/visualizer

## Docker Daemon config file

   If we want to communicate with docker engine from a docker cli on another host, we can modify daemon configuration by using a file at /etc/docker/daemon.json or running dockerd command.

        {
            "debug": true,
            "hosts": ["tcp://192.168.1.10:2376"],
            "tls": true,
            "tlscert": "/var/docker/server.pem",
            "tlskey": "/var/docker/serverkey.pem",
            "tlsverify": true,
            "tlscacert": "/var/docker/cacert.pem"
        }

     dockerd --debug \
             --host=tcp://192.168.1.10:2376 \
             --tls=true \
             --tlscert=/var/docker/server.pem \
             --tlskey=/var/docker/serverkey.pem

## Restart Policies

    - docker container run --restart=no : By deafult. Never automatically restarted.
    - docker container run --restart=on-failure  : Restarts container only when it fails. Determined by exit code.
    - docker container run --restart=always  : Restarts whether container exits successfully or on failure. If manually stopped, container will be scheduled to restart during next containerd daemon restarts.
    - docker container run --restart=unless-stopped  : Restarts whether container exits successfully or on failure but does not restart of its stopped manually.

 **Live Restore**

    By default, when dockerd daemon stops/crashes, all the container running on the docker host will go down. In order to keep the containers running even when dockerd daemon crashes, we need to configure live restore option in /etc/docker/daemon.json file.

        {
            "debug": true,
            "hosts": ["tcp://192.168.1.10:2376"],
            "live-restore": true
        }

## Copying contents into container

     - docker container cp /tmp/web.conf webapp:/etc/
     - docker container cp webapp:/etc/web.conf /tmp/

## Publishing ports

   If a docker host has multiple network interfaces and we want to publish a container port to the host's specific network interface we provide IP address to the -p option in the docker run command.

     docker run -p 192.168.1.5:8000:5000 web-app
    
   Only make the container port accessible on docker host and no externally.
     
     docker run -p 127.0.0.1:8000:5000 web-app

   Publish a random port

     docker run -P -itd httpd

## Docker debugging

   To enable debugging mode, update /etc/docker/daemon.json file with "debug":true

        {
            "debug":true
        }

## Logging drivers

   Logs are stored at /var/lib/docker/containers/<containerid>/<containerid>.json file.
   These logs can be sent to aws cloutwatch or anywhere by using log-driver. Update the file /etc/docker/daemon.json file with required driver.

     {
        "log-driver": "awslogs",
        "log-opt": {
            "awslogs-region": "us-east-1"
        }
     }

   We can also specify loggin driver during container creation/run

     docker run -d --log-driver json-file nginx
     docker run -d --log-driver awslogs nginx
    

## Docker File

  **Copy Vs ADD**

    ADD app.tar.gz /testdir : ADD will extract the app.tar.gz into container's /testdir
    ADD http://app.tar.gz /testdir 

    COPY just copies the file as is.

  **CMD vs ENTRYPOINT**

    with CMD we cannot pass in the arguments separately. with ENTRYPOINT we can pass arguments which gets appeneded to the ENTRYPOINT's command.

## Resource Limits

 **CPU**
    
    docker run --cpu-shares=512 nginx  : limit cpu resources for a container. - soft limit
    docker run --cpuset-cpus=0-1 httpd  : assign CPUs to a comtainer
    docker un --cpus=2.5 webapp  :  hard limit. restrict a container to use only 2.5 out of x cpus on the host.
    docker container update --cpus=0.5 webapp  : update limits.

**Memory**

    docker run --memory=512m nginx  :  use only 512 MB of memory to nginx container on docker host. Hard Limit.
    container gets killed if it uses more than allocated memory throwing out of memory exception.

    docker run --memory=512m --memory-swarp=768m nginx  : swap space = 768-512 = 256 MB

