This is a repository to run brat using a docker image based on httpd:2.4.

## Setup

### On a local environment

1. Run the brat container. If there is not the image, it is built at the beginning. In this process, account information in `docker-compose.yml` is used.
```
docker-compose up -d
```

2. To enable brat app to modify ann files, change permission of `data` directory in the container. This directory is mounted from the host.
```
docker exec brat bash -c "chgrp -R daemon data && chmod -R g+rwx data"
```

3. Access `http://localhost/brat`.

### On an EC2 instance

1. Install docker.
```
bash install_docker.sh
```

2. Modify username, password, and email on `docker-compose.yml`. They will be used for the master account.

3. Add `users.json` in `config` directory to specify additional users. An example of users.json:
```
{
  "site_suffix_1": {
    "user_1": "password_1",
    "user_2": "password_2"
  }
}
```

4. Build the brat image, providing information of the first account as the arguments. The account information can be specified also in `docker-compose.yml`.
```
sudo docker compose build --build-arg username=<username> --build-arg password=<password> --build-arg email=<email>
```

5. Run the brat container.
```
sudo docker compose up -d
```

6. To enable brat app to modify ann files, change permission of `data` directory in the container. This directory is mounted from the host.
```
sudo docker exec brat bash -c "chgrp -R daemon data && chmod -R g+rwx data"
```

7. Access `http://<ip address>/brat`.

## Other Docker operations

Check if containers are running
```
docker ps
```

Enter the running brat container
```
docker exec -it brat bash
```

Stop the brat container
```
docker stop brat
```
