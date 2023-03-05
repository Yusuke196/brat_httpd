This is a repository to run brat using a docker image based on httpd:2.4.

## Arranging brat files

Arrange txt files, ann files, annotation.conf, and visual.conf in `data` directory.

## Setup

### On a local environment

1. Install and start docker.

2. Run the brat container. If there is not the image, it is built at the beginning. In this process, account information in `docker-compose.yml` is used.
```
docker-compose up -d
```

3. To enable brat app to modify ann files, change permission of `data` directory in the container. This directory is mounted from the host.
```
docker exec brat bash -c "chgrp -R www-data brat/data && chmod -R g+rwx brat/data"
```

4. Access `http://localhost/brat`.

### On an EC2 instance

1. Install docker.
```
bash install_docker.sh
```

2. Modify username, password, and email on `docker-compose.yml`. They will be used for the master account that is available on every site.

3. (Optional) To add accounts, add `users.json` as below in `config` directory. This setting creates an account of "user_1" and "password_1" for `http://<ip address>/brat`.
```
{
  "": {
    "user_1": "password_1"
  }
}
```

4. Run the brat container.
```
sudo docker compose up -d
```

5. To enable brat app to modify ann files, change permission of `data` directory in the container. This directory is mounted from the host.
```
sudo docker exec brat bash -c "chgrp -R www-data brat/data && chmod -R g+rwx brat/data"
```

6. Access `http://<ip address>/brat`.

### To run additional sites

You can run additional brat sites (applications) on a single server. An additional site will have the URL `http://<ip address>/brat-<suffix>` after you follow the below steps.

1. Add lines as below on Dockerfile providing suffixes of the sites.
```
RUN sh ./add_site.sh <suffix>
```

2. (Optional) To add accounts, add key-value pairs as below on `config/users.json`.
```
  "<suffix>": {
    "user_2": "password_2"
  }
```

3. Duplicate `data` directory with the name of `data-<suffix>`.

4. Add items to the list of volumes on `docker-compose.yml`.
```
- type: bind
  source: ./data-<suffix>
  target: /usr/local/apache2/htdocs/brat-<suffix>/data
```

5. Build the image and container again.
```
sudo docker compose up -d --build
```

6. Enable each brat app to modify ann files in each directory.
```
sudo docker exec brat bash -c "chgrp -R www-data brat-${suffix}/data && chmod -R g+rwx brat-${suffix}/data"
```

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
