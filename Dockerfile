FROM centos:7

RUN echo "Install from repos"
RUN yum -y install epel-release
RUN yum -y install http://linux.davisnetworks.com/el7/updates/mrdvt92-release-8-3.el7.mrdvt92.noarch.rpm
RUN yum -y update

RUN yum -y install httpd
RUN yum -y install perl-Power-Outlet-application-cgi #v0.50-9

COPY ./power-outlet.ini /etc/
COPY ./index.html /var/www/html/

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"] #starts apache
