## Fresh install Nexus on ubuntu docker container

   #### Bring up ubuntu container
   
        docker run -dit --name sonarqube --hostname sonarqube -p9000:9000 ubuntu
        
   #### update package list
   
        apt-get update
        
   #### Install wget, jdk, vim, systemctl, sudo
   
        apt-get install wget wim systemctl sudo -y
        apt-get install openjdk-8-jdk -y
        6
        44
      
