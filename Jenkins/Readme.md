##Install Jenkins on ubuntu container

   ####in Windows host
   
    docker run -dit --name jenkins -v "${pwd}:/home/jenkins" ubuntu
    
   #### in linux host
   
    docker run -dit --name jenkins -v "/home/<directory>:/home/jenkins" ubuntu
    
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

    wget https://get.jenkins.io/war-stable/2.289.2/jenkins.war .
