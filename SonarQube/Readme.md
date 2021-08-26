## Fresh install Nexus on ubuntu docker container

   #### Bring up ubuntu container
   
     docker run -dit --name sonarqube --hostname sonarqube -p9000:9000 ubuntu
        
   #### update package list
   
     apt update
        
   #### Install wget, jdk11, vim, systemctl, sudo lsb-release gnupg2
   
     apt install wget wim systemctl sudo lsb-release gnupg2 -y
     apt install openjdk-11-jdk -y
     6
     44
        
   #### Install and configure PostgreSQL
   
     sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
     wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
     apt install postgresql postgresql-contrib -y
     6
     44
        
   #### Start database server
         
     pg_ctlcluster 12 main start

     systemctl enable postgresql
     systemctl start postgresql
        
   #### Change default password for postgres user
   
     passwd postgres
     su - postgres
        
   #### Create a new user 'sonar'
        
     createuser sonar
        
   #### Switch to the PostgreSQL shell
   
     psql
        
   #### Set a password for the newly created user for SonarQube database.
   
     ALTER USER sonar WITH ENCRYPTED password 'sonar';
        
   #### Create a new database for PostgreSQL database by running:
   
     CREATE DATABASE sonarqube OWNER sonar;
        
   #### grant all privileges to sonar user on sonarqube Database.
   
     grant all privileges on DATABASE sonarqube to sonar;
        
   #### Exit from the psql shell:
   
     \q
        
   #### Switch back to the sudo user by running the exit command.
   
     exit
   
   ### Download and install sonarqube
         
     #using root
     cd /tmp
     wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.0.0.45539.zip -O sonarqube.zip
     unzip sonarqube.zip -d /opt
        
   #### Create a group 'sonar' and give ownership of /opt/sonarqube to 'sonar' user
   
     groupadd sonar
     useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonar sonar

     chown -R sonar:sonar /opt/sonarqube
        
   #### Edit sonarqube config file and update PostgreSQL username and password for sonar created above.
   
     vi /opt/sonarqube/conf/sonar.properties

     # uncomment below lines and provide username and password
     sonar.jdbc.username=sonar
     sonar.jdbc.password=sonar
        
   #### Edit sonar script file and set RUN_AS_USER to sonar
   
     vi /opt/sonarqube/bin/linux-x86-64/sonar.sh

     # uncomment RUN_AS_USER= and set sonar.
     RUN_AS_USER=sonar
        
  ### Start SonarQube
  
    su sonar
    cd /opt/sonarqube/bin/linux-x86-64/
    ./sonar.sh start

    # Check SonarQube Running Status
    ./sonar.sh status

    # SonarQube Logs:
    tail /opt/sonarqube/logs/sonar.log
       
  ### Configure systemd service
  
     
        
        
   
        
      
      
