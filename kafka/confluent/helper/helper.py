#!/usr/bin/env python

from template.python.argument_parse import *
from template.python.command import *
from template.python.fileio import *
from template.python.log4j_prop import *
from template.python.other import *
from template.python.parallel_ssh import *
from template.python.prop import *
from template.python.read_template import *
from template.python.read_value import *
from template.python.script import *
from template.python.service import *
from template.python.symlink import *


# region server_file


def create_server_file(base, server_dict, prop_dict, log4j_dict, start_dict, stop_dict, log_dict):
    for server_type, servers in server_dict.items():
        for server in servers:
            if server_type == ServerType.ZOOKEEPER:
                create_prop_file(server, prop_dict.get(ServerType.ZOOKEEPER),
                                 server_dict.get(ServerType.ZOOKEEPER))
            elif server_type == ServerType.CONTROL_CENTER:
                create_control_center_prop_file(server, prop_dict.get(ServerType.CONTROL_CENTER),
                                                server_dict.get(ServerType.KAFKA_CONNECT),
                                                server_dict.get(ServerType.REPLICATOR),
                                                server_dict.get(ServerType.KSQLDB))
            else:
                create_prop_file(server, prop_dict.get(server_type))

            create_start_script_file(base, server, start_dict.get(server_type))
            create_stop_script_file(base, server, stop_dict.get(server_type))
            create_log_script_file(server, log_dict.get(ServerType.ANY))

    for server in [servers[0] for servers in server_dict.values() if servers]:
        create_common_stop_script_file(base, server, stop_dict.get(server.server_type))

    for server_type, log4j_prop in log4j_dict.items():
        create_log4j_prop_file(server_type, log4j_prop)


# endregion

# region server_service_file


def create_server_service_file(base, server_dict, service_dict, service_env_dict):
    for server_type, servers in server_dict.items():
        for server in servers:
            create_service_script_file(base, server, service_dict.get(server_type))
            create_service_env_file(base, server, service_env_dict.get(server_type))


# endregion

# region other_file


def create_other_file(base, server_dict):
    create_symlink_by_hostname_script_file(server_dict)
    create_symlink_by_servername_script_file(server_dict)
    create_add_host_script_file(server_dict)
    create_secure_copy_script_file(base, server_dict)
    create_kafka_alias_file(base)


# endregion

# region pssh_file


def create_pssh_file(base, server_dict, pssh_start_dict, pssh_stop_dict, pssh_kill_dict):
    create_pssh_host_file(base, server_dict)
    create_pssh_script_file(base, pssh_start_dict, pssh_stop_dict, pssh_kill_dict)


# endregion

# region command_file


def create_command_file(base, server_dict, command_dict):
    for command_type, command_script in command_dict.items():
        create_topic_command_file(base, server_dict, command_type, command_script)


# endregion


######################################################################


# region main


def main():
    # parse arguments
    values_file = get_value_file()

    # reset output directory
    current_dir = pathlib.Path(__file__).parent.absolute()
    reset_output_dir(current_dir)

    # read values
    rendered_file_name = render_values_file(current_dir, values_file)
    values_data = read_yaml_file(rendered_file_name)
    base_data = read_base_data(values_data)
    server_data = read_server_data(values_data)

    # read templates
    prop_data = read_prop_template_data(current_dir)
    log4j_data = read_log4j_template_data(current_dir)
    start_data = read_start_template_data(current_dir)
    stop_data = read_stop_template_data(current_dir)
    log_data = read_log_template_data(current_dir)
    service_data = read_service_template_data(current_dir)
    service_env_data = read_service_env_template_data(current_dir)
    pssh_start_data = read_pssh_start_template_data(current_dir)
    pssh_stop_data = read_pssh_stop_template_data(current_dir)
    pssh_kill_data = read_pssh_kill_template_data(current_dir)
    command_data = read_command_template_data(current_dir)

    # create script and property files
    create_server_file(base_data, server_data, prop_data, log4j_data,
                       start_data, stop_data, log_data)
    # create overriding service files
    create_server_service_file(base_data, server_data, service_data, service_env_data)
    # create other files
    create_other_file(base_data, server_data)
    # create pssh host files
    create_pssh_file(base_data, server_data, pssh_start_data, pssh_stop_data, pssh_kill_data)
    # create command files
    create_command_file(base_data, server_data, command_data)


if __name__ == "__main__":
    main()

# endregion
