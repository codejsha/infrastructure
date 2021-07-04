#!/usr/bin/env python

from template.python.enumeration import ServerType
from template.python.fileio import write_file
from template.python.function import *


def create_start_script_file(base, server, start_script):
    edited_start = start_script
    edited_start = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_start)
    edited_start = replace_variable('SERVER_NAME', f'{server.server_name}', edited_start)
    edited_start = replace_variable('PROPERTIES_FILE',
                                    f'{base.properties_dir}/{server.file.properties}', edited_start)
    edited_start = replace_variable('LOG_DIR', f'{server.log_dir}', edited_start)
    edited_start = replace_variable('JAVA_HOME', f'{base.java_home}', edited_start)

    if server.server_type in \
            [ServerType.ZOOKEEPER, ServerType.KAFKA, ServerType.KSQLDB, ServerType.CONTROL_CENTER]:
        edited_start = replace_variable('DATA_DIR', f'{server.data_dir}', edited_start)

    if server.server_type == ServerType.ZOOKEEPER:
        edited_start = replace_variable('MYID', f'{server.server_id}', edited_start)

    write_file(f'output/scripts/{server.file.start}', edited_start)


def create_stop_script_file(base, server, stop_script):
    edited_stop = stop_script
    edited_stop = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_stop)
    write_file(f'output/scripts/{server.file.stop}', edited_stop)


def create_log_script_file(server, log_script):
    edited_log = log_script
    edited_log = replace_variable('SERVER_NAME', f'{server.server_name}', edited_log)
    edited_log = replace_variable('LOG_DIR', f'{server.log_dir}', edited_log)
    write_file(f'output/scripts/{server.file.log}', edited_log)


def create_common_stop_script_file(base, server, stop_script):
    edited_stop = stop_script
    edited_stop = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_stop)
    write_file(f'output/scripts/{server.stop_script}', edited_stop)
