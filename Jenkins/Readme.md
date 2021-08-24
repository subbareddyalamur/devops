## Install Jenkins on ubuntu container

   #### in Windows host
   
    docker run -dit --name jenkins -p 8000:8080 -v "${pwd}:/home/jenkins" ubuntu
    
   #### in linux host
   
    docker run -dit --name jenkins -p 8000:8080 -v "/home/<directory>:/home/jenkins" ubuntu
    
### connect to container

     docker exec -it jenkins /bin/bash
     
### install java

    apt update
    apt install default-jdk -y
    6
    44

### check if java is installed

    javac -version

### download jenkins.war
    
    apt-get install wget
    wget https://get.jenkins.io/war-stable/2.289.2/jenkins.war .

### run jenkins

    java -jar jenkins.war
*********************************************************
### Install jenkins and running as a service

    # prerequisites to install gnupg or gnupg1 or gnupg2
    apt-get install gnupg2
    
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    apt-get update
    apt-get install jenkins
    
    # start jenkins service
    apt-get install systemctl
    
    systemctl start jenkins
    
#### access jenkins GUI by opening http://localhost:8080/ on host machine.

### Create and customize jenkins image using dockerfile

      FROM jenkins/jenkins
      LABEL maintainer="hitjethva@gmail.com"
      USER root
      RUN mkdir /var/log/jenkins
      RUN mkdir /var/cache/jenkins
      RUN chown -R jenkins:jenkins /var/log/jenkins
      RUN chown -R jenkins:jenkins /var/cache/jenkins
      USER jenkins

      ENV JAVA_OPTS="-Xmx8192m"
      ENV JENKINS_OPTS="--handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"
      
### Run jenkins in a container using docker-compose

      version: '3'
      services:
        jenkins1:
          hostname: jenkins
          image: jenkins
          ports:
            - 9081:8080
