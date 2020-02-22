FROM ubuntu
RUN apt-get update
RUN apt-get install nginx -y
COPY ./web/ /var/www/html/flutter
EXPOSE 80
CMD ["nginx","-g","daemon off;"]