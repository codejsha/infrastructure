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
    print(ansiformat.bold + '%-30s' % _header + ansiformat.reset + '|'),
    for _server_name in _server_names:
        print('%15s' % _server_name),
    print('')
    print('-' * (31 + (16 * len(_server_names))))


def print_status_value(_items, _values):
    _transposed_values = list(map(list, zip(*_values)))

    for _idx in range(len(_items)):
        print('%-30s' % _items[_idx][0] + '|'),
        if _items[_idx][1] == 'bool':
            for v in _transposed_values[_idx]:
                if v == 0:
                    print(''.join(str('%15s' % 'False'))),
                else:
                    print(''.join(str('%15s' % 'True'))),
        elif _items[_idx][1] == 'int':
            print(' '.join([str('%15i' % v) for v in _transposed_values[_idx]])),
        elif _items[_idx][1] == 'long':
            print(' '.join([str('%15i' % v) for v in _transposed_values[_idx]])),
        elif _items[_idx][1] == 'double':
            print(' '.join([str('%15.4f' % v) for v in _transposed_values[_idx]])),
        else:
            print(' '.join([str('%15s' % v) for v in _transposed_values[_idx]])),
        print('')
    print('\n')


def get_server_general_status(_servers):
    print('%-20s %-10s %-35s %-10s' %
          ('ServerName', 'State', 'ListenAddress', 'ListenPort'))
    print('------------------------------------------------------------------------------')
    for _server in _servers:
        print('%-20s' % _server.getName()),
        if _server.getState() == 'RUNNING':
            print(ansifgcolor.light_green + '%-10s' % _server.getState() +
                  ansiformat.reset),
        elif _server.getState() == 'ADMIN':
            print(ansifgcolor.light_yellow + '%-10s' % _server.getState() +
                  ansiformat.reset),
        else:
            print(ansifgcolor.light_red + '%-10s' % _server.getState() +
                  ansiformat.reset),
        print('%-35s' % _server.getListenAddress()),
        print('%10s' % _server.getListenPort())
    print('\n')


def get_server_heap_status(_servers):
    _server_names = [server.getName() for server in _servers]

    _heap_items = [
        ('HeapSizeMax', 'long'),
        ('HeapSizeCurrent', 'long'),
        ('HeapFreeCurrent', 'long'),
        ('HeapFreePercent', 'int')
    ]

    _heap_values = []
    for _server in _servers:
        _heap_values.append([
            _server.getJVMRuntime().getHeapSizeMax(),
            _server.getJVMRuntime().getHeapSizeCurrent(),
            _server.getJVMRuntime().getHeapFreeCurrent(),
            _server.getJVMRuntime().getHeapFreePercent(),
        ])

    print_status_header('HEAP', _server_names)
    print_status_value(_heap_items, _heap_values)


def get_server_threadpool_status(_domain_version, _servers):
    _server_names = [server.getName() for server in _servers]
    _is_ver_1212_or_later = False
    if ('12.' in _domain_version) or ('14.' in _domain_version):
        _is_ver_1212_or_later = True
        if '12.1.1' in _domain_version:
            _is_ver_1212_or_later = False

    _threadpool_items = [
        ('CompletedRequestCount', 'long'),
        ('ExecuteThreadIdleCount', 'int'),
        ('ExecuteThreadTotalCount', 'int'),
        ('HoggingThreadCount', 'int'),
        ('MinThreadsConstraintsCompleted', 'long'),
        ('MinThreadsConstraintsPending', 'int'),
        ('PendingUserRequestCount', 'int'),
        ('QueueLength', 'int'),
        ('SharedCapacityForWorkManagers', 'int'),
        ('StandbyThreadCount', 'int'),
        ('Throughput', 'double'),
        ('Suspended', 'bool')
    ]
    if _is_ver_1212_or_later:
        _threadpool_items.append(('OverloadRejectedRequestsCount', 'int'))
        _threadpool_items.append(('StuckThreadCount', 'int'))

    _threadpool_values = []
    for _server in _servers:
        _list = [
            _server.getThreadPoolRuntime().getCompletedRequestCount(),
            _server.getThreadPoolRuntime().getExecuteThreadIdleCount(),
            _server.getThreadPoolRuntime().getExecuteThreadTotalCount(),
            _server.getThreadPoolRuntime().getHoggingThreadCount(),
            _server.getThreadPoolRuntime().getMinThreadsConstraintsCompleted(),
            _server.getThreadPoolRuntime().getMinThreadsConstraintsPending(),
            _server.getThreadPoolRuntime().getPendingUserRequestCount(),
            _server.getThreadPoolRuntime().getQueueLength(),
            _server.getThreadPoolRuntime().getSharedCapacityForWorkManagers(),
            _server.getThreadPoolRuntime().getStandbyThreadCount(),
            _server.getThreadPoolRuntime().getThroughput(),
            _server.getThreadPoolRuntime().isSuspended(),
        ]
        if _is_ver_1212_or_later:
            _list.append(_server.getThreadPoolRuntime().getOverloadRejectedRequestsCount())
            _list.append(_server.getThreadPoolRuntime().getStuckThreadCount())
        _threadpool_values.append(_list)

    print_status_header('THREADPOOL', _server_names)
    print_status_value(_threadpool_items, _threadpool_values)


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
if len(servers) > 0:
    get_server_general_status(servers)
    get_server_heap_status(servers)
    get_server_threadpool_status(domain_version, servers)

exit()
