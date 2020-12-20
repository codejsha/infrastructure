# Apache HTTP Server

## Install

- http://httpd.apache.org/docs/current/install.html

## Binding

- https://httpd.apache.org/docs/current/bind.html

## Cache

- http://httpd.apache.org/docs/current/mod/mod_expires.html
- https://httpd.apache.org/docs/current/mod/mod_headers.html
- https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control

## Directory

- https://httpd.apache.org/docs/current/mod/core.html#options
- https://httpd.apache.org/docs/current/mod/mod_dir.html#directoryindex
- https://httpd.apache.org/docs/current/mod/mod_authz_core.html#require

## Compression

- https://httpd.apache.org/docs/current/mod/mod_deflate.html
- https://httpd.apache.org/docs/current/filter.html

test:

```bash
curl -I -H "Accept-Encoding:gzip,deflate" http://test.example.com
```

## Logging

- https://httpd.apache.org/docs/current/logs.html
- https://httpd.apache.org/docs/current/programs/rotatelogs.html
- https://httpd.apache.org/docs/current/mod/mod_log_config.html

## HTTP2

- https://httpd.apache.org/docs/current/howto/http2.html
- https://httpd.apache.org/docs/current/mod/mod_http2.html
- https://httpd.apache.org/docs/current/mod/core.html#protocols
- https://nghttp2.org/documentation/nghttp.1.html
- https://nghttp2.org/documentation/h2load-howto.html

## Reverse proxy

- https://httpd.apache.org/docs/current/mod/mod_proxy.html
- https://httpd.apache.org/docs/current/mod/mod_proxy_http.html
- https://httpd.apache.org/docs/current/mod/mod_proxy_balancer.html
- https://httpd.apache.org/docs/current/mod/mod_proxy_connect.html
- https://httpd.apache.org/docs/current/mod/mod_http2.html
- https://httpd.apache.org/docs/current/mod/mod_proxy_ajp.html
- https://httpd.apache.org/docs/current/mod/mod_proxy_wstunnel.html

## Virtual host

- https://httpd.apache.org/docs/current/vhosts/
- https://httpd.apache.org/docs/current/vhosts/name-based.html
- https://httpd.apache.org/docs/current/vhosts/ip-based.html
