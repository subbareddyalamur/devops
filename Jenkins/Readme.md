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

    wget https://get.jenkins.io/war-stable/2.289.2/jenkins.war .

### run jenkins

    java -jar jenkins.war
    
#### access jenkins GUI by opening http://localhost:8080/ on host machine.
