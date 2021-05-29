#!/usr/bin/env python

from template.python.fileio import *


def create_symlink_by_hostname_script_file(server_dict):
    data_list = [f'#!/bin/bash\n']

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
                             f'        -o -name "{server.file.more}" -o -name "{server.stop_script}" \) | xargs rm -f')

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
    write_file('output/others/create-symlink-by-hostname.sh', edited_symlink)


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
        f'find . -maxdepth 1 -name "*.sh" \\',
        f'    -not \( -name "start-${{SERVER_NAME}}.sh" -o -name "stop-${{SERVER_NAME}}.sh" \\',
        f'    -o -name "log-${{SERVER_NAME}}.sh" -o -name "grep-${{SERVER_NAME}}.sh" \\',
        f'    -o -name "more-${{SERVER_NAME}}.sh" -o -name "stop-${{SERVER_NAME_REMOVED_NUMBER}}.sh" \) | xargs rm -f',
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
    write_file('output/others/create-symlink-by-servername.sh', edited_symlink)


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


def create_secure_copy_script_file(base, server_dict):
    data_list = [
        f'#!/bin/bash\n',
        f'tar -czf confluent-others.tar.gz ../others/',
        f'tar -czf confluent-properties.tar.gz ../properties/',
        f'tar -czf confluent-scripts.tar.gz ../scripts/',
        f'tar -czf confluent-services.tar.gz ../services/',
        f'',
        f'# tar -czf confluent-others.tar.gz others/',
        f'# tar -czf confluent-properties.tar.gz properties/',
        f'# tar -czf confluent-scripts.tar.gz scripts/',
        f'# tar -czf confluent-services.tar.gz services/'
    ]

    # host name
    data_list.append(f'\n######################################################################\n')
    data_list.append(f'### host name\n')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'scp confluent-others.tar.gz '
                             f'{base.user}@{server.host_name}:{base.confluent_home}')
    data_list.append(f'')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'scp confluent-properties.tar.gz '
                             f'{base.user}@{server.host_name}:{base.confluent_home}')
    data_list.append(f'')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'scp confluent-scripts.tar.gz '
                             f'{base.user}@{server.host_name}:{base.confluent_home}')
    data_list.append(f'')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'scp confluent-services.tar.gz '
                             f'{base.user}@{server.host_name}:{base.confluent_home}')

    # host address
    data_list.append(f'\n######################################################################\n')
    data_list.append(f'### host address\n')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'# scp confluent-others.tar.gz '
                             f'{base.user}@{server.host_address}:{base.confluent_home}')
    data_list.append(f'')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'# scp confluent-properties.tar.gz '
                             f'{base.user}@{server.host_address}:{base.confluent_home}')
    data_list.append(f'')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'# scp confluent-scripts.tar.gz '
                             f'{base.user}@{server.host_address}:{base.confluent_home}')
    data_list.append(f'')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'# scp confluent-services.tar.gz '
                             f'{base.user}@{server.host_address}:{base.confluent_home}')

    edited_hosts = '\n'.join(data_list) + '\n'
    write_file('output/others/scp-files.sh', edited_hosts)


def create_kafka_alias_file(base):
    data_list = [
        f'### kafka aliases',
        f'###',
        f'### [ -f ~/.kafka_aliases ] && source ~/.kafka_aliases',
        f'###\n',
        f'CONFLUENT_HOME={base.confluent_home}',
        f'PATH="${{PATH}}:${{CONFLUENT_HOME}}/bin"',
        f'JAVA_HOME={base.java_home}',
        f'PATH="${{PATH}}:${{JAVA_HOME}}/bin"',
        f'export PATH',
        f'',
        f'alias psef="ps -ef | grep"',
        f'alias pxjava="pgrep -xa java | grep java"',
        f'alias pxprometheus="pgrep -xa prometheus | grep prometheus"',
        f'alias pxgrafana="pgrep -xa grafana-server | grep grafana-server"',
        f'alias pxlagexporter="pgrep -xa kafka-lag-exporter | grep kafka-lag-exporter"',
        f'alias pxnodeexporter="pgrep -xa node_exporter | grep node_exporter"',
        f'',
        f'alias killjava="pkill -9 -ecx java"',
        f'alias killprometheus="pkill -9 -ecx prometheus"',
        f'alias killgrafana="pkill -9 -ecx grafana-server"',
        f'alias killlagexporter="pkill -9 -ecx kafka-lag-exporter"',
        f'alias killnodeexporter="pkill -9 -ecx node_exporter"',
        f'',
        f'alias killzookeeper="pkill -9 -ecf \\"org.apache.zookeeper.server.quorum.QuorumPeerMain\\""',
        f'alias killkafka="pkill -9 -ecf \\"kafka.Kafka\\""',
        f'alias killschemaregistry="pkill -9 -ecf \\"io.confluent.kafka.schemaregistry.rest.SchemaRegistryMain\\""',
        f'alias killkafkaconnect="pkill -9 -ecf \\"org.apache.kafka.connect.cli.ConnectDistributed\\""',
        f'alias killkafkarest="pkill -9 -ecf \\"io.confluent.kafkarest.KafkaRestMain\\""',
        f'alias killksqldb="pkill -9 -ecf \\"io.confluent.ksql.rest.server.KsqlServerMain\\""',
        f'alias killcontrolcenter="pkill -9 -ecf \\"io.confluent.controlcenter.ControlCenter\\""',
        f'alias killconfluent="killzookeeper; killkafka; killschemaregistry; killkafkaconnect; killkafkarest; killksqldb; killcontrolcenter;"',
        f'',
        f'alias goconfluent="cd ${{CONFLUENT_HOME}}"',
        f'alias goprops="cd ${{CONFLUENT_HOME}}/properties"',
        f'alias goscripts="cd ${{CONFLUENT_HOME}}/scripts"',
        f'alias goconnector="cd ${{CONFLUENT_HOME}}/connectors"',
        f'',
        f'alias startsh="${{CONFLUENT_HOME}}/scripts/start.sh"',
        f'alias stopsh="${{CONFLUENT_HOME}}/scripts/stop.sh"',
        f'alias logsh="${{CONFLUENT_HOME}}/scripts/log.sh"',
        f'alias grepsh="${{CONFLUENT_HOME}}/scripts/grep.sh"',
        f'alias moresh="${{CONFLUENT_HOME}}/scripts/more.sh"'
    ]

    edited_hosts = '\n'.join(data_list) + '\n'
    write_file('output/others/.kafka_aliases', edited_hosts)
