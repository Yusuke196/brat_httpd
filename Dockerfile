FROM httpd:2.4
RUN apt-get update && apt-get install -y \
  wget \
  vim \
  python \
  apache2

WORKDIR /usr/local/apache2/htdocs/
RUN wget https://github.com/nlplab/brat/archive/refs/tags/v1.3_Crunchy_Frog.tar.gz -O - | tar xzf -
RUN mv brat-1.3_Crunchy_Frog brat

WORKDIR /usr/local/apache2/htdocs/brat/
COPY ./install_brat.sh .
ARG username
ARG password
ARG email
RUN bash ./install_brat.sh $username $password $email

COPY config/httpd.conf /usr/local/apache2/conf/

COPY config/add_users.py .
COPY config/users.json .
RUN python add_users.py config.py users.json
COPY config/modify_tools.py .
RUN python modify_tools.py

# Note: data directory will be mounted by specification in docker-compose.yml
# after build operation, so its permission cannot be changed here
RUN chgrp -R $(./apache-group.sh) work
RUN chmod -R g+rwx work

EXPOSE 80
