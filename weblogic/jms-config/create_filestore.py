#!/usr/bin/env python

domain_name = os.environ.get('DOMAIN_NAME')
admin_server_listen_address = os.environ.get('ADMIN_SERVER_LISTEN_ADDRESS')
admin_server_listen_port = os.environ.get('ADMIN_SERVER_LISTEN_PORT')
admin_username = os.environ.get('ADMIN_USERNAME')
admin_password = os.environ.get('ADMIN_PASSWORD')

filestore_name = os.environ.get('FILESTORE_NAME')
filestore_dir = os.environ.get('FILESTORE_DIR')
filestore_target = os.environ.get('FILESTORE_TARGET')


######################################################################


def create_filestore(_filestore_name):
    cd('/')
    if _filestore_name not in [filestore.getName() for filestore in cmo.getFileStores()]:
        cmo.createFileStore(_filestore_name)


def set_filestore_general_config(_filestore_name, _filestore_dir, _filestore_target):
    cd('/FileStores/' + _filestore_name)
    cmo.setDirectory(_filestore_dir)
    set('Targets', jarray.array(
        [ObjectName('com.bea:Name=' + _filestore_target + ',Type=Server')], ObjectName))


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

create_filestore(filestore_name)
set_filestore_general_config(filestore_name, filestore_dir, filestore_target)

save()
activate()
exit()
