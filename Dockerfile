FROM httpd:latest
BROKEN///!
WORKDIR /usr/local/apache2/htdocs/
COPY ./public-html/* .
EXPOSE 80


