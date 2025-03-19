FROM almalinux:9

RUN echo "Install from repos"
RUN yum -y install epel-release
RUN /usr/bin/crb enable
RUN yum -y install https://linux.davisnetworks.com/el9/updates/mrdvt92-release-8-3.el9.mrdvt92.noarch.rpm
RUN yum -y update

RUN yum -y install httpd
RUN yum -y install perl-Power-Outlet-application-cgi #v0.50-9

COPY ./power-outlet.ini /etc/
COPY ./index.html /var/www/html/
COPY ./ServerName.conf /etc/httpd/conf.d/
COPY ./power-outlet.conf /etc/httpd/conf.d/

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
