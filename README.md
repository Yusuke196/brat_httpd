This is a repository to run brat on a docker image based on httpd:2.4.

## Setup

### On a local environment

1. Build an image and a container, and run the container
```
docker build -t brat-httpd --build-arg username=user --build-arg password=password --build-arg email=example@mail.com .
docker run --rm --name brat -p 80:80 brat-httpd
```

2. Access `http://localhost/brat`

### On an EC2 instance

1. Build an image and a container, and run the container
```
# Change the username, password, and email as appropriate
sudo docker build -t brat-httpd --build-arg username=user --build-arg password=password --build-arg email=example@mail.com .
# By adding `-d`, the container keeps running in the background
sudo docker run --rm --name brat -p 80:80 -d --privileged brat-httpd
```

2. Access `http://<ip address>/brat`
