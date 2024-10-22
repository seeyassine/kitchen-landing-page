FROM ubuntu:latest AS BUILD_IMAGE
RUN apt update && apt install git -y
RUN git clone https://github.com/seeyassine/kitchen-landing-page.git /kitchen-landing-page

FROM ubuntu:latest
LABEL "project"="kitchen"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install apache2 git -y
COPY --from=BUILD_IMAGE /kitchen-landing-page /var/www/html/

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
VOLUME /var/log/apache2
WORKDIR /var/www/html/
EXPOSE 80
