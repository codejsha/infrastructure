#!/usr/bin/env python

from template.python.fileio import write_file


def create_kafka_alias_file(base):
    data_list = [
        f'### kafka aliases',
        f'###',
        f'### [ -f ~/.kafka_aliases ] && source ~/.kafka_aliases',
        f'###',
        f'',
        f'CONFLUENT_HOME={base.confluent_home}',
        f'PATH="${{PATH}}:${{CONFLUENT_HOME}}/bin"',
        f'export PATH',
        f'',
        f'JAVA_HOME={base.java_home}',
        f'export JAVA_HOME',
        f'PATH="${{PATH}}:${{JAVA_HOME}}/bin"',
        f'export PATH',
        f'',
        f'alias pxjava="pgrep -xa java | grep java"',
        f'alias pxprometheus="pgrep -xa prometheus | grep prometheus"',
        f'alias pxgrafana="pgrep -xa grafana-server | grep grafana-server"',
        f'alias pxnodeexporter="pgrep -xa node_exporter | grep node_exporter"',
        f'alias pxlagexporter="pgrep -xa java | grep kafka-lag-exporter"',
        f'alias pxelasticsearch="pgrep -xa java | grep elasticsearch"',
        f'alias pxkibana="pgrep -xa node | grep kibana"',
        f'',
        f'alias killjava="pkill -9 -ecx java"',
        f'',
        f'alias goconfluent="cd ${{CONFLUENT_HOME}}"',
        f'alias goprops="cd ${{CONFLUENT_HOME}}/properties"',
        f'alias goscripts="cd ${{CONFLUENT_HOME}}/scripts"',
        f'alias goconnector="cd ${{CONFLUENT_HOME}}/connectors"'
    ]

    edited_aliases = '\n'.join(data_list) + '\n'
    write_file('output/others/.kafka_aliases', edited_aliases)


def create_add_host_script_file(server_dict):
    data_list = [f'#!/bin/bash\n']

    data_list.append(f'### append\n')
    data_list.append(f'cat <<EOF | sudo tee -a /etc/hosts')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'{server.host_address} {server.host_name}')
    data_list.append(f'EOF')
    data_list.append(f'\n######################################################################\n')

    data_list.append(f'### overwrite\n')
    data_list.append(f'# cat <<EOF | sudo tee /etc/hosts')
    data_list.append(f'# 127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4')
    data_list.append(f'# ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'# {server.host_address} {server.host_name}')
    data_list.append(f'# EOF')

    edited_hosts = '\n'.join(data_list) + '\n'
    write_file('output/others/add-hosts.sh', edited_hosts)


def create_copy_archive_script_file(base, server_dict):
    data_list = [
        f'#!/bin/bash',
        f'',
        f'cd ..',
        f'tar -czf confluent-log4j.tar.gz log4j/',
        f'tar -czf confluent-others.tar.gz others/',
        f'tar -czf confluent-properties.tar.gz properties/',
        f'tar -czf confluent-pssh.tar.gz pssh/',
        f'tar -czf confluent-scripts.tar.gz scripts/',
        f'tar -czf confluent-services.tar.gz services/',
        f'',
        f'set -o xtrace'
    ]

    # host name
    data_list.append(f'\n######################################################################\n')
    data_list.append(f'### host name\n')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(
                f'scp confluent-log4j.tar.gz confluent-others.tar.gz confluent-properties.tar.gz confluent-pssh.tar.gz confluent-scripts.tar.gz confluent-services.tar.gz '
                f'{base.user}@{server.host_name}:{base.confluent_home}')

    # host address
    data_list.append(f'\n######################################################################\n')
    data_list.append(f'### host address\n')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(
                f'# scp confluent-log4j.tar.gz confluent-others.tar.gz confluent-properties.tar.gz confluent-pssh.tar.gz confluent-scripts.tar.gz confluent-services.tar.gz '
                f'{base.user}@{server.host_address}:{base.confluent_home}')

    edited_script = '\n'.join(data_list) + '\n'
    write_file('output/others/scp-files.sh', edited_script)


def create_parallel_copy_archive_script_file(base, server_dict):
    data_list = [
        f'#!/bin/bash',
        f'',
        f'cd ..',
        f'tar -czf confluent-log4j.tar.gz log4j/',
        f'tar -czf confluent-others.tar.gz others/',
        f'tar -czf confluent-properties.tar.gz properties/',
        f'tar -czf confluent-pssh.tar.gz pssh/',
        f'tar -czf confluent-scripts.tar.gz scripts/',
        f'tar -czf confluent-services.tar.gz services/',
        f'',
        f'set -o xtrace',
        f'',
        f'######################################################################',
        f'',
        f'pscp.pssh \\',
        f'    --hosts=../pssh/hosts/zookeeper.hosts \\',
        f'    --hosts=../pssh/hosts/kafka.hosts \\',
        f'    --hosts=../pssh/hosts/schema-registry.hosts \\',
        f'    --hosts=../pssh/hosts/kafka-connect.hosts \\',
        f'    --hosts=../pssh/hosts/replicator.hosts \\',
        f'    --hosts=../pssh/hosts/kafka-rest.hosts \\',
        f'    --hosts=../pssh/hosts/ksqldb.hosts \\',
        f'    --hosts=../pssh/hosts/control-center.hosts \\',
        f'    --askpass \\',
        f'    confluent-log4j.tar.gz confluent-others.tar.gz confluent-properties.tar.gz confluent-pssh.tar.gz confluent-scripts.tar.gz confluent-services.tar.gz \\',
        f'    {base.confluent_home}',
    ]

    edited_script = '\n'.join(data_list) + '\n'
    write_file('output/others/pscp-files.sh', edited_script)
