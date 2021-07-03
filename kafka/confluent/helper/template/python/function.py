#!/usr/bin/env python

import re


# region server_specific


def generate_zookeeper_cluster_list(server_id, servers):
    cluster_list = []
    for server in servers:
        if server.server_id == server_id:
            cluster_list.append(f'server.{server.server_id}='
                                f'0.0.0.0:{server.leader_port}:{server.leader_election_port}')
        else:
            cluster_list.append(f'server.{server.server_id}='
                                f'{server.server_name}:{server.leader_port}:{server.leader_election_port}')
    return cluster_list


# endregion

# region function


def append_param(param, param_value, prev_keyword, prop):
    edited_prop = re.sub(f'\n{prev_keyword}', f'\n{prev_keyword}\n{param}={param_value}', prop, count=1)
    return edited_prop


def replace_param(param, param_value, prop):
    if param_value == 'None':
        edited_prop = re.sub(f'\n{param}=.*', f'\n# {param}=', prop, count=1)
    else:
        edited_prop = re.sub(f'\n{param}=.*', f'\n{param}={param_value}', prop, count=1)
    return edited_prop


def replace_variable(variable, variable_value, script):
    edited_script = re.sub(f'\n{variable}=.*', f'\n{variable}="{variable_value}"', script, count=1)
    return edited_script


def substitute_variable(variable, variable_value, script):
    edited_script = re.sub(f'\${{{variable}}}', f'{variable_value}', script)
    return edited_script


def get_unique_cluster_list(cluster_servers):
    cluster_list = []
    for servers in cluster_servers:
        cluster_list.append(servers.group_id)
    unique_cluster_list = list(set(cluster_list))
    return unique_cluster_list


def get_sub_cluster_domain_url_dict(cluster_servers):
    temp_dict = {}
    cluster_dict = {}

    for server in cluster_servers:
        if server.group_id in temp_dict:
            temp_dict[f'{server.group_id}'].append(f'http://{server.host_name}:{server.listen_port}')
        else:
            temp_dict[f'{server.group_id}'] = [f'http://{server.host_name}:{server.listen_port}']
    for gid, url in temp_dict.items():
        cluster_dict[gid] = ','.join(url)

    return cluster_dict


def get_sub_cluster_address_url_dict(cluster_servers):
    temp_dict = {}
    cluster_dict = {}

    for server in cluster_servers:
        if server.group_id in temp_dict:
            temp_dict[f'{server.group_id}'].append(f'http://{server.host_address}:{server.listen_port}')
        else:
            temp_dict[f'{server.group_id}'] = [f'http://{server.host_address}:{server.listen_port}']
    for gid, url in temp_dict.items():
        cluster_dict[gid] = ','.join(url)

    return cluster_dict

# endregion
