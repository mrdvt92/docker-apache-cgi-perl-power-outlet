FROM centos:7

ENV container docker

RUN echo "centos7-systemd: From: https://hub.docker.com/_/centos#Systemd+integration";\
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);\
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*;\
rm -f /lib/systemd/system/sockets.target.wants/*udev*;\
rm -f /lib/systemd/system/sockets.target.wants/*initctl*;\
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*

RUN echo "Install from repos"
RUN yum -y install epel-release
RUN yum -y install http://linux.davisnetworks.com/el7/updates/mrdvt92-release-8-3.el7.mrdvt92.noarch.rpm
RUN yum -y update

RUN yum -y install httpd
RUN yum -y install perl-Power-Outlet-application-cgi
RUN systemctl enable httpd

COPY ./power-outlet.ini /etc/
COPY ./index.html /var/www/html/

EXPOSE 80

CMD ["/usr/sbin/init"] #start systemd
