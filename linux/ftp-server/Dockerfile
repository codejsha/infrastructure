FROM centos:7.5.1804

RUN yum install -y vsftpd; yum clean all;

### Enable FTP Passive Mode
RUN echo -e "\n# Passive mode\npasv_enable=YES\npasv_min_port=10400\npasv_max_port=10410" >> /etc/vsftpd/vsftpd.conf
