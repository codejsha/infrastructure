#!/usr/bin/env python

from template.python.fileio import write_file


def create_symlink_by_hostname_script_file(server_dict):
    data_list = [
        f'#!/bin/bash\n',
        f'mkdir backup\n'
    ]

    is_first = True
    for server_type, servers in server_dict.items():
        for server in servers:
            if is_first:
                data_list.append(f'if [ "$(hostname)" == "{server.host_name}" ]; then')
                is_first = False
            else:
                data_list.append(f'elif [ "$(hostname)" == "{server.host_name}" ]; then')

            data_list.append(f'    find . -maxdepth 1 -name "*.sh" \\\n'
                             f'        -not \( -name "{server.file.start}" -o -name "{server.file.stop}" \\\n'
                             f'        -o -name "{server.file.log}" -o -name "{server.file.grep}" \\\n'
                             f'        -o -name "{server.file.more}" -o -name "{server.stop_script}" \) | xargs -I {{}} mv {{}} backup/')

            data_list.append(f'    if [ -f "{server.file.start}" ]; then')
            data_list.append(f'        ln -snf {server.file.start} start.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.file.stop}" ]; then')
            data_list.append(f'        ln -snf {server.file.stop} stop.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.file.log}" ]; then')
            data_list.append(f'        ln -snf {server.file.log} log.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.file.grep}" ]; then')
            data_list.append(f'        ln -snf {server.file.grep} grep.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.file.more}" ]; then')
            data_list.append(f'        ln -snf {server.file.more} more.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.stop_script}" ]; then')
            data_list.append(f'        ln -snf {server.stop_script} stop.sh')
            data_list.append(f'    fi')
    data_list.append(f'fi')

    edited_symlink = '\n'.join(data_list) + '\n'
    write_file('output/scripts/create-symlink-by-hostname.sh', edited_symlink)


def create_symlink_by_servername_script_file(server_dict):
    data_list = [
        f'#!/bin/bash\n',
        f'SERVER_NAME="${{1}}"',
        f'SERVER_NAME_REMOVED_NUMBER="$(echo ${{SERVER_NAME}} | sed \'s/[0-9]//g\')"',
        f'',
        f'if [[ ${{#}} -eq 0 ]]; then',
        f'    echo "[ERROR] No argument provided!"',
        f'    exit 1',
        f'fi',
        f'',
        f'mkdir backup\n',
        f'find . -maxdepth 1 -name "*.sh" \\',
        f'    -not \( -name "start-${{SERVER_NAME}}.sh" -o -name "stop-${{SERVER_NAME}}.sh" \\',
        f'    -o -name "log-${{SERVER_NAME}}.sh" -o -name "grep-${{SERVER_NAME}}.sh" \\',
        f'    -o -name "more-${{SERVER_NAME}}.sh" -o -name "stop-${{SERVER_NAME_REMOVED_NUMBER}}.sh" \) | xargs -I {{}} mv {{}} backup/',
        f'',
        f'if [ -f "start-${{SERVER_NAME}}.sh" ]; then',
        f'    ln -snf start-${{SERVER_NAME}}.sh start.sh',
        f'fi',
        f'if [ -f "stop-${{SERVER_NAME}}.sh" ]; then',
        f'    ln -snf stop-${{SERVER_NAME}}.sh stop.sh',
        f'fi',
        f'if [ -f "log-${{SERVER_NAME}}.sh" ]; then',
        f'    ln -snf log-${{SERVER_NAME}}.sh log.sh',
        f'fi',
        f'if [ -f "grep-${{SERVER_NAME}}.sh" ]; then',
        f'    ln -snf grep-${{SERVER_NAME}}.sh grep.sh',
        f'fi',
        f'if [ -f "more-${{SERVER_NAME}}.sh" ]; then',
        f'    ln -snf more-${{SERVER_NAME}}.sh more.sh',
        f'fi',
        f'if [ -f "stop-${{SERVER_NAME_REMOVED_NUMBER}}.sh" ]; then',
        f'    ln -snf stop-${{SERVER_NAME_REMOVED_NUMBER}}.sh stop.sh',
        f'fi'
    ]

    edited_symlink = '\n'.join(data_list) + '\n'
    write_file('output/scripts/create-symlink-by-servername.sh', edited_symlink)
