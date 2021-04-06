# Apache HTTP Server

- http://httpd.apache.org/docs/current/

## Apache Tomcat Connector

edit jk log file path in mod_jk.conf

include mod_jk.conf file in httpd.conf:

```conf
# Apache Tomcat Connector (mod_jk)
Include conf/jk/mod_jk.conf
```

copy config files to httpd home:

```bash
bash ./httpd-tomcat.sh
```

## Compression

test:

```bash
curl -I -H "Accept-Encoding:gzip,deflate" http://test.example.com
```
