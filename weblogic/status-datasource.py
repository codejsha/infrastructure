#!/usr/bin/env python

class ansiformat(object):
    reset = '\033[0m'
    bold = '\033[1m'
    underline = '\033[4m'
    blink = '\033[5m'


class ansifgcolor(object):
    light_red = '\033[91m'
    light_green = '\033[92m'
    light_yellow = '\033[93m'
    light_blue = '\033[94m'
    light_magenta = '\033[95m'
    light_cyan = '\033[96m'


######################################################################


def print_status_header(_header, _server_names):
    print(ansiformat.bold + '%-33s' % _header + ansiformat.reset + '|'),
    for _server_name in _server_names:
        print('%25s' % _server_name),
    print('')


def print_status_sub_header(_datasource_names):
    print(' ' * 33 + '|'),
    for _datasource_name in _datasource_names:
        print('%25s' % _datasource_name),
    print('')
    print('-' * (34 + 26 * len(_datasource_names)))


def print_status_value(_items, _values):
    _trans_values = list(map(list, zip(*_values)))

    for _idx in range(len(_items)):
        print('%-33s' % _items[_idx][0] + '|'),
        if _items[_idx][1] == 'bool':
            for v in _trans_values[_idx]:
                if v == 0:
                    print(''.join(str('%25s' % 'False'))),
                else:
                    print(''.join(str('%25s' % 'True'))),
        elif _items[_idx][1] == 'int':
            print(' '.join([str('%25i' % v) for v in _trans_values[_idx]])),
        elif _items[_idx][1] == 'long':
            print(' '.join([str('%25i' % v) for v in _trans_values[_idx]])),
        elif _items[_idx][1] == 'double':
            print(' '.join([str('%25.4f' % v) for v in _trans_values[_idx]])),
        else:
            print(' '.join([str('%25s' % v) for v in _trans_values[_idx]])),
        print('')
    print('\n')


def get_server_datasource_status(_servers):
    _datasource_length = 0
    _server_names = []
    _datasource_names = []

    _datasource_items = [
        ('ActiveConnectionsAverageCount', 'int'),
        ('ActiveConnectionsCurrentCount', 'int'),
        ('ActiveConnectionsHighCount', 'int'),
        ('ConnectionDelayTime', 'int'),
        ('ConnectionsTotalCount', 'int'),
        ('CurrCapacity', 'int'),
        ('CurrCapacityHighCount', 'int'),
        ('DeploymentState', 'int'),
        ('FailedReserveRequestCount', 'long'),
        ('FailuresToReconnectCount', 'int'),
        ('HighestNumAvailable', 'int'),
        ('HighestNumUnavailable', 'int'),
        ('LeakedConnectionCount', 'int'),
        ('ModuleId', 'str'),
        ('Name', 'str'),
        ('NumAvailable', 'int'),
        ('NumUnavailable', 'int'),
        # ('Parent', 'str'),
        ('PrepStmtCacheAccessCount', 'long'),
        ('PrepStmtCacheAddCount', 'long'),
        ('PrepStmtCacheCurrentSize', 'int'),
        ('PrepStmtCacheDeleteCount', 'long'),
        ('PrepStmtCacheHitCount', 'int'),
        ('PrepStmtCacheMissCount', 'int'),
        ('Properties', 'str'),
        ('ReserveRequestCount', 'long'),
        ('State', 'str'),
        ('Type', 'str'),
        ('VersionJDBCDriver', 'str'),
        ('WaitingForConnectionCurrentCount', 'int'),
        ('WaitingForConnectionFailureTotal', 'long'),
        ('WaitingForConnectionHighCount', 'int'),
        ('WaitingForConnectionSuccessTotal', 'long'),
        ('WaitingForConnectionTotal', 'int'),
        ('WaitSecondsHighCoun', 'int')
    ]

    _datasource_values = []
    for _server in _servers:
        _datasources = _server.getJDBCServiceRuntime().getJDBCDataSourceRuntimeMBeans()
        _datasource_length = len(_datasources)
        for _datasource in _datasources:
            _server_names.append(_server.getName())
            _datasource_names.append(_datasource.getName())
            _list = [
                _datasource.getActiveConnectionsAverageCount(),
                _datasource.getActiveConnectionsCurrentCount(),
                _datasource.getActiveConnectionsHighCount(),
                _datasource.getConnectionDelayTime(),
                _datasource.getConnectionsTotalCount(),
                _datasource.getCurrCapacity(),
                _datasource.getCurrCapacityHighCount(),
                _datasource.getDeploymentState(),
                _datasource.getFailedReserveRequestCount(),
                _datasource.getFailuresToReconnectCount(),
                _datasource.getHighestNumAvailable(),
                _datasource.getHighestNumUnavailable(),
                _datasource.getLeakedConnectionCount(),
                _datasource.getModuleId(),
                _datasource.getName(),
                _datasource.getNumAvailable(),
                _datasource.getNumUnavailable(),
                # _datasource.getParent(),
                _datasource.getPrepStmtCacheAccessCount(),
                _datasource.getPrepStmtCacheAddCount(),
                _datasource.getPrepStmtCacheCurrentSize(),
                _datasource.getPrepStmtCacheDeleteCount(),
                _datasource.getPrepStmtCacheHitCount(),
                _datasource.getPrepStmtCacheMissCount(),
                _datasource.getProperties(),
                _datasource.getReserveRequestCount(),
                _datasource.getState(),
                _datasource.getType(),
                _datasource.getVersionJDBCDriver(),
                _datasource.getWaitingForConnectionCurrentCount(),
                _datasource.getWaitingForConnectionFailureTotal(),
                _datasource.getWaitingForConnectionHighCount(),
                _datasource.getWaitingForConnectionSuccessTotal(),
                _datasource.getWaitingForConnectionTotal(),
                _datasource.getWaitSecondsHighCount()
            ]
            _datasource_values.append(_list)

    if _datasource_values > 0:
        print_status_header('DATASOURCE', _server_names)
        print_status_sub_header(_datasource_names)
        print_status_value(_datasource_items, _datasource_values)
    else:
        print("[INFO] Datasources are not available.")


######################################################################


admin_server_listen_address = 'test.example.com'
admin_server_listen_port = '7001'
admin_username = 'weblogic'
admin_password = 'welcome1'

admin_server_url = 't3://' + admin_server_listen_address + ':' + admin_server_listen_port
connect(admin_username, admin_password, admin_server_url)

domain_version = cmo.getDomainVersion()
domainRuntime()

servers = domainRuntimeService.getServerRuntimes()
if (len(servers) > 0):
    get_server_datasource_status(servers)

exit()
