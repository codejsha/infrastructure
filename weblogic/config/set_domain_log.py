#!/usr/bin/env python

domain_name = os.environ.get('DOMAIN_NAME')
log_dir = os.environ.get('LOG_DIR')
admin_server_listen_address = os.environ.get('ADMIN_SERVER_LISTEN_ADDRESS')
admin_server_listen_port = os.environ.get('ADMIN_SERVER_LISTEN_PORT')
admin_username = os.environ.get('ADMIN_USERNAME')
admin_password = os.environ.get('ADMIN_PASSWORD')


######################################################################


def set_domain_log_config(_domain_name, _log_dir):
    cd('/Log/' + _domain_name)
    cmo.setDateFormatPattern('MMM d, yyyy h:mm:ss,SSS a z')
    # cmo.setFileName(_log_dir + '/domain/'
    #                 'domain_' + '_domain_name' + '_%%yyyy%%%%MM%%%%dd%%_%%HH%%%%mm%%%%ss%%.log')
    cmo.setFileName('/dev/null')
    cmo.setRotationType('byTime')
    cmo.setNumberOfFilesLimited(True)
    cmo.setFileCount(30)
    cmo.setFileTimeSpan(24)
    cmo.setRotationTime('00:00')
    cmo.setRotateLogOnStartup(False)
    cmo.setBufferSizeKB(0)


######################################################################


admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)
edit()
startEdit()

set_domain_log_config(domain_name, log_dir)

save()
activate()
exit()
