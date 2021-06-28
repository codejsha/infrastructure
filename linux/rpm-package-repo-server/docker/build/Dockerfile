FROM centos:7.9.2009

RUN yum install -y httpd; yum clean all;

WORKDIR /etc/httpd/conf
COPY server/httpd.conf .

WORKDIR /etc/yum.repos.d
RUN mkdir backup && mv *.repo backup
COPY server/example-repo.repo .
RUN yum clean all

WORKDIR /var/www/html/example-repo

CMD [ "/usr/sbin/httpd", "-DFOREGROUND" ]
