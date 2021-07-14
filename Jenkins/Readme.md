##Install Jenkins on ubuntu container

    #in Windows host
    docker run -dit --name jenkins -v "${pwd}:/home/jenkins" ubuntu
    
    # in linux host
    docker run -dit --name jenkins -v "/home/<directory>:/home/jenkins" ubuntu
    
### connect to container
     docker exec -it jenkins /bin/bash
     
### install java
    
