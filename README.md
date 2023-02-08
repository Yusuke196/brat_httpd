This is a repository to run brat using a docker image based on httpd:2.4.

## Setup

### On a local environment

1. Run the brat container (if there is not the image or the container, they are set up beforehand)
```
docker-compose up -d
```

2. To enable brat app to modify ann files, change permission of `data` directory in the container
```
docker exec brat bash -c "chgrp -R daemon data && chmod -R g+rwx data"
```
docker exec brat bash -c "chgrp -R daemon data && chmod -R g+rwx data"

3. Access `http://localhost/brat`

### On an EC2 instance

1. Run the brat container
```
sudo docker build -t brat-httpd --build-arg username=<username> --build-arg password=<password> --build-arg email=<email> .
# By adding `-d`, the container keeps running in the background
sudo docker run --rm --name brat -p 80:80 -d --privileged brat-httpd
```

2. Access `http://<ip address>/brat`

## Other Docker operations

Check if containers are running
```
docker ps
```

Enter the running brat container
```
docker exec -it brat bash
```

Copy data from the host machine to the container
(This is automatically done when you build a new docker container)
```
docker cp data brat:/usr/local/apache2/htdocs/brat/
```

Copy annotated data from the container to the host machine (example)
```
docker cp brat:/usr/local/apache2/htdocs/brat/data/wmt22 annotation
```

Stop the brat container
```
docker stop brat
```
