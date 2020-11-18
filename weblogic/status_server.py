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


def print_status_header(_server_names, _header):
    print(ansiformat.bold + '%-30s' % _header + ansiformat.reset + '|'),
    for _server_name in _server_names:
        print('%15s' % _server_name),
    print('')
    print('-' * (31 + 16 * len(_server_names)))


def print_status_value(_items, _values):
    _trans_values = list(map(list, zip(*_values)))

    for _idx in range(len(_items)):
        print('%-30s' % _items[_idx] + '|'),
        if isinstance(_trans_values[_idx][0], bool):
            print(''.join([str('%15r' % v) for v in _trans_values[_idx]])),
        elif isinstance(_trans_values[_idx][0], int):
            print(''.join([str('%15i' % v) for v in _trans_values[_idx]])),
        elif isinstance(_trans_values[_idx][0], float):
            print(''.join([str('%15.4f' % v) for v in _trans_values[_idx]])),
        else:
            print(''.join([str('%15s' % v) for v in _trans_values[_idx]])),
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
        'HeapSizeMax',
        'HeapSizeCurrent',
        'HeapFreeCurrent',
        'HeapFreePercent'
    ]

    _heap_values = []
    for _server in _servers:
        _heap_values.append([
            _server.getJVMRuntime().getHeapSizeMax(),
            _server.getJVMRuntime().getHeapSizeCurrent(),
            _server.getJVMRuntime().getHeapFreeCurrent(),
            _server.getJVMRuntime().getHeapFreePercent(),
        ])

    print_status_header(_server_names, 'HEAP')
    print_status_value(_heap_items, _heap_values)


def get_server_threadpool_status(_servers):
    _server_names = [server.getName() for server in _servers]
    _is_ver_1212_or_later = False

    _threadpool_items = [
        'CompletedRequestCount',
        'ExecuteThreadIdleCount',
        'ExecuteThreadTotalCount',
        'HoggingThreadCount',
        'MinThreadsConstraintsCompleted',
        'MinThreadsConstraintsPending',
        'PendingUserRequestCount',
        'QueueLength',
        'SharedCapacityForWorkManagers',
        'StandbyThreadCount',
        'Throughput',
        'Suspended'
    ]

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
        if ('12.' in _server.getWeblogicVersion()) and ('14.' in _server.getWeblogicVersion()):
            _is_ver_1212_or_later = True
            _list.append(_server.getThreadPoolRuntime().getOverloadRejectedRequestsCount())
            _list.append(_server.getThreadPoolRuntime().getStuckThreadCount())
        _threadpool_values.append(_list)

    if _is_ver_1212_or_later:
        _threadpool_items.append('OverloadRejectedRequestsCount')
        _threadpool_items.append('StuckThreadCount')

    print_status_header(_server_names, 'THREADPOOL')
    print_status_value(_threadpool_items, _threadpool_values)


######################################################################


admin_server_url = 't3://test.example.com:7001'
username = 'weblogic'
password = 'welcome1'
connect(username, password, admin_server_url)

domainRuntime()

servers = domainRuntimeService.getServerRuntimes()
if (len(servers) > 0):
    get_server_general_status(servers)
    get_server_heap_status(servers)
    get_server_threadpool_status(servers)
