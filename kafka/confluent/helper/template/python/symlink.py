#!/usr/bin/env python

from template.python.fileio import write_file


def create_symlink_by_hostname_script_file(server_dict):
    data_list = [
        f'#!/bin/bash\n',
        f'mkdir -p backup\n',
        f'find . -maxdepth 1 -name "*.sh" | xargs chmod 750\n'
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
                             f'        -o -name "{server.file.log}" -o -name "{server.stop_script}" \\\n'
                             f'        -o -name "*topic*.sh" \) | xargs -I {{}} mv {{}} backup/')

            data_list.append(f'    if [ -f "{server.file.start}" ]; then')
            data_list.append(f'        ln -snf {server.file.start} start.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.file.stop}" ]; then')
            data_list.append(f'        ln -snf {server.file.stop} stop.sh')
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
        f'SERVER_NAME_NUMBER_REMOVED="$(echo ${{SERVER_NAME}} | sed \'s/[0-9]//g\')"',
        f'',
        f'if [[ ${{#}} -eq 0 ]]; then',
        f'    echo "[ERROR] No argument provided!"',
        f'    exit 1',
        f'fi',
        f'',
        f'mkdir -p backup\n',
        f'find . -maxdepth 1 -name "*.sh" | xargs chmod 750',
        f'find . -maxdepth 1 -name "*.sh" \\',
        f'    -not \( -name "start-${{SERVER_NAME}}.sh" -o -name "stop-${{SERVER_NAME}}.sh" \\',
        f'    -o -name "log-${{SERVER_NAME}}.sh" -o -name "grep-${{SERVER_NAME}}.sh" \\',
        f'    -o -name "more-${{SERVER_NAME}}.sh" -o -name "stop-${{SERVER_NAME_NUMBER_REMOVED}}.sh" \\\n'
        f'    -o -name "*topic*.sh" \) | xargs -I {{}} mv {{}} backup/',
        f'',
        f'if [ -f "start-${{SERVER_NAME}}.sh" ]; then',
        f'    ln -snf start-${{SERVER_NAME}}.sh start.sh',
        f'fi',
        f'if [ -f "stop-${{SERVER_NAME}}.sh" ]; then',
        f'    ln -snf stop-${{SERVER_NAME}}.sh stop.sh',
        f'fi',
        f'if [ -f "stop-${{SERVER_NAME_NUMBER_REMOVED}}.sh" ]; then',
        f'    ln -snf stop-${{SERVER_NAME_NUMBER_REMOVED}}.sh stop.sh',
        f'fi'
    ]

    edited_symlink = '\n'.join(data_list) + '\n'
    write_file('output/scripts/create-symlink-by-servername.sh', edited_symlink)
