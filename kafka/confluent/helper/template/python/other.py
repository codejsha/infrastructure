#!/usr/bin/env python

from template.python.fileio import *


def create_start_and_stop_symlink_script_file(common_list, server_dict):
    data_list = [f'#!/bin/bash\n']
    total_server_count = sum(map(len, server_dict.values()))

    index = 1
    for server_type, servers in server_dict.items():
        for server in servers:
            if index == 1:
                data_list.append(f'if [ "$(hostname)" == "{server.host_name}" ]; then')
            else:
                data_list.append(f'elif [ "$(hostname)" == "{server.host_name}" ]; then')

            data_list.append(f'    if [ -f "{server.file.start_file}" ]; then')
            data_list.append(f'        ln -snf {server.file.start_file} start.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.file.stop_file}" ]; then')
            data_list.append(f'        ln -snf {server.file.stop_file} stop.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.file.log_file}" ]; then')
            data_list.append(f'        ln -snf {server.file.log_file} log.sh')
            data_list.append(f'    fi')

            if index == total_server_count:
                data_list.append(f'fi\n')
            index += 1

    index = 1
    for server in common_list:
        if index == 1:
            data_list.append(f'if [ -f "{server.file.stop_file}" ]; then')
        else:
            data_list.append(f'elif [ -f "{server.file.stop_file}" ]; then')

        data_list.append(f'    ln -snf {server.file.stop_file} stop.sh')

        if index == len(common_list):
            data_list.append(f'fi')
        index += 1

    edited_symlink = '\n'.join(data_list) + '\n'
    write_file('scripts/others/create-symlink.sh', edited_symlink)


def create_add_host_script_file(server_dict):
    data_list = [
        f'#!/bin/bash\n',
        f'cat << EOF | sudo tee -a /etc/hosts'
    ]

    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'{server.ip_address} {server.host_name}')

    data_list.append(f'EOF')
    edited_hosts = '\n'.join(data_list) + '\n'
    write_file('scripts/others/add-hosts.sh', edited_hosts)


def create_secure_copy_script_file(base, server_dict):
    data_list = [
        f'#!/bin/bash\n',
        f'tar -czf ../../properties/* confluent-properties.tar.gz',
        f'tar -czf ../../scripts/* confluent-scripts.tar.gz',
        f'# tar -czf properties/* confluent-properties.tar.gz',
        f'# tar -czf scripts/* confluent-scripts.tar.gz\n'
    ]

    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'scp confluent-properties.tar.gz '
                             f'{base.user}@{server.ip_address}:{base.confluent_home}')
            data_list.append(f'scp confluent-scripts.tar.gz '
                             f'{base.user}@{server.ip_address}:{base.confluent_home}')
    data_list.append(f'')

    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'# scp confluent-properties.tar.gz '
                             f'{base.user}@{server.host_name}:{base.confluent_home}')
            data_list.append(f'# scp confluent-scripts.tar.gz '
                             f'{base.user}@{server.host_name}:{base.confluent_home}')

    edited_hosts = '\n'.join(data_list) + '\n'
    write_file('scripts/others/scp-files.sh', edited_hosts)


def create_kafka_alias_file(base):
    data_list = [
        f'### kafka aliases\n',
        f'CONFLUENT_HOME={base.confluent_home}',
        f'PATH="${{PATH}}:${{CONFLUENT_HOME}}/bin"',
        f'export PATH\n',
        f'alias killjava="pkill -9 java"',
        f'alias pxjava="pgrep -xa java"',
        f'alias goprops="cd ${{CONFLUENT_HOME}}/properties"',
        f'alias goscripts="cd ${{CONFLUENT_HOME}}/scripts"',
        f'alias startsh="${{CONFLUENT_HOME}}/scripts/start.sh"',
        f'alias stopsh="${{CONFLUENT_HOME}}/scripts/stop.sh"',
        f'alias logsh="${{CONFLUENT_HOME}}/scripts/log.sh"'
    ]

    edited_hosts = '\n'.join(data_list) + '\n'
    write_file('scripts/others/.kafka_aliases', edited_hosts)
