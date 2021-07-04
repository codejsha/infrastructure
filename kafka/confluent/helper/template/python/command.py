#!/usr/bin/env python

from template.python.enumeration import *
from template.python.fileio import write_file
from template.python.function import *


def create_topic_command_file(base, server_dict, command_type, command_script):
    edited_command = command_script
    edited_command = replace_variable('CONFLUENT_HOME', f'{base.confluent_home}', edited_command)
    first_server = server_dict.get(ServerType.KAFKA)[0]
    edited_command = substitute_variable('VAR_BOOTSTRAP_SERVER',
                                         f'{first_server.metrics_reporter_bootstrap_servers}', edited_command)

    if command_type == TopicCommandType.CREATE:
        write_file(f'output/commands/create-topic.sh', edited_command)
    elif command_type == TopicCommandType.DELETE:
        write_file(f'output/commands/delete-topic.sh', edited_command)
    elif command_type == TopicCommandType.DESCRIBE:
        write_file(f'output/commands/describe-topic.sh', edited_command)
    elif command_type == TopicCommandType.LIST:
        write_file(f'output/commands/get-topic-list.sh', edited_command)
