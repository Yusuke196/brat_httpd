FROM httpd:2.4
RUN apt-get update && apt-get install -y wget python apache2

WORKDIR /usr/local/apache2/htdocs/
RUN wget https://github.com/nlplab/brat/archive/refs/tags/v1.3_Crunchy_Frog.tar.gz -O - | tar xzf -
RUN mv brat-1.3_Crunchy_Frog brat

# Note: in the name of the unzipped directory, v doesn't exist before 1.3
WORKDIR /usr/local/apache2/htdocs/brat/
COPY ./install.sh .
ARG username
ARG password
ARG email
RUN bash ./install.sh $username $password $email

COPY ./httpd.conf /usr/local/apache2/conf/

EXPOSE 80
