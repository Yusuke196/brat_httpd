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

COPY config/additional.conf /usr/local/apache2/conf/
RUN cat /usr/local/apache2/conf/additional.conf >> /usr/local/apache2/conf/httpd.conf
COPY config/modify_tools.py .
RUN python modify_tools.py
# Note: data directory will be mounted by specification in docker-compose.yml
# after build operation, so its permission cannot be changed here
RUN chgrp -R $(./apache-group.sh) work && chmod -R g+rwx work

WORKDIR /usr/local/apache2/htdocs/
COPY config/add_users.py .
COPY config/users.json .
COPY config/add_site.sh .
RUN python add_users.py config.py users.json

# Set up configs for additional sites. The argument will be the suffix of the site
# RUN sh ./add_site.sh apple

EXPOSE 80
