#!/bin/bash -eu

NAME=$1
if [[ -z $1 ]]; then
  echo >&2 "Supply the name of the site"
  exit 1
fi

cp -ra brat brat-$NAME

python add_users.py config.py users.json --site_suffix $NAME

echo "
<Directory \"/usr/local/apache2/htdocs/brat-$NAME\">
    AllowOverride Options Indexes FileInfo Limit
    AddType application/xhtml+xml .xhtml
    AddType font/ttf .ttf
    # For CGI support
    AddHandler cgi-script .cgi
</Directory>\
" >> /usr/local/apache2/conf/httpd.conf

echo "\
<VirtualHost *:80>
  ServerName $NAME
  DocumentRoot /usr/local/apache2/htdocs/brat-$NAME
</VirtualHost>\
" > /etc/apache2/sites-available/$NAME.conf

a2ensite $NAME
