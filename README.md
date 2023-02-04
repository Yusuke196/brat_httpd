This is a repository to run brat on a docker image based on httpd:2.4.

## Setup

1. Build an image and a container, and run the container
```
docker build -t brat-httpd --build-arg username=user --build-arg password=password --build-arg email=example@mail.com .
docker run --rm --name brat -p 80:80 brat-httpd
```

2. Access `http://localhost/brat`
