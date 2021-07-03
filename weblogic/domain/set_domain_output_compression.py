#!/usr/bin/env python

domain_name = os.environ['DOMAIN_NAME']
admin_server_listen_address = os.environ['ADMIN_SERVER_LISTEN_ADDRESS']
admin_server_listen_port = os.environ['ADMIN_SERVER_LISTEN_PORT']
admin_username = os.environ['ADMIN_USERNAME']
admin_password = os.environ['ADMIN_PASSWORD']

compress_content_type = os.environ['COMPRESS_CONTENT_TYPE']


######################################################################


def set_domain_output_compression(_domain_name, _compress_content_type):
    _content_type_list = [content_type.strip() for content_type in _compress_content_type.split(',')]

    cd('/WebAppContainer/' + _domain_name + '/GzipCompression/' + _domain_name)
    cmo.setGzipCompressionEnabled(true)
    cmo.setGzipCompressionMinContentLength(2048)
    _objects = []
    for _content_type in _content_type_list:
        _objects.append(str(_content_type))
    set('GzipCompressionContentType', jarray.array(_objects, String))


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

set_domain_output_compression(domain_name, compress_content_type)

save()
activate()
exit()
