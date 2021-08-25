### Run nexus as a container using docker-compose

    version: "2"
    services:
      nexus:
        image: sonatype/nexus
        volumes:
          - "nexus-data:/sonatype-work"
        ports:
          - "8081:8081"

    volumes:
      nexus-data: {}

### Fresh install Nexus on ubuntu docker container

   #### Bring up ubuntu container
   
        docker run -dit --name nexus --hostname nexus -p9081:8081 ubuntu
        
   #### update package list
   
        apt-get update
        
   #### Install wget, jdk, vim, systemctl, sudo
   
        apt-get install wget wim systemctl sudo -y
        apt-get install openjdk-8-jdk -y
        6
        44
        
   #### Download Nexus and extract to /tmp/nexus
   
        mkdir /tmp/nexus
        cd /tmp/nexus
        wget https://download.sonatype.com/nexus/3/nexus-3.33.1-01-unix.tar.gz -O nexus.tar.gz
        tar -zxvf nexus.tar.gz
        ls
        mv nexus-3.33.1-01 /opt/nexus
        mv sonatype-work /opt/
        
   #### Add user nexus 
   
        useradd nexus
        
   #### Give permissions to nexus user for /opt/nexus and /opt/sonatype-work dirs
   
        chown -R nexus:nexus /opt/nexus
        chown -R nexus:nexus /opt/sonatype-work
        
   #### Edit /opt/nexus/bin/nexus.rc file to rus as nexus user instead of root
   
        echo 'run_as_user="nexus"' > /opt/nexus/bin/nexus.rc
        
   #### Configur nexus to run as a service.
        
        cat <<EOT>> /etc/systemd/system/nexus.service
        
        [Unit]
        Description=nexus service
        After=network.target
        [Service]
        Type=forking
        LimitNOFILE=65536
        User=nexus
        Group=nexus
        ExecStart=/opt/nexus/bin/nexus start
        ExecStop=/opt/nexus/bin/nexus stop
        User=nexus
        Restart=on-abort
        [Install]
        WantedBy=multi-user.target
        
        EOT
        
   #### Enable and start nexus
   
        systemctl enable nexus
        systemctl start nexus
        systemctl status nexus
        
   #### Open browser on localhost and navigate to localhost:9081 to access Nexus GUI.
        

        
