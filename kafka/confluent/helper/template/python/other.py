#!/usr/bin/env python

from template.python.fileio import *


def create_start_and_stop_symlink_script_file(server_dict):
    data_list = [f'#!/bin/bash\n']
    total_server_count = sum(map(len, server_dict.values()))

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
                             f'        -o -name "{server.stop_script}" -o -name "{server.file.log}" \\\n'
                             f'        -o -name "{server.file.grep}" -o -name "{server.file.more}" \) | xargs rm -f')

            data_list.append(f'    if [ -f "{server.file.start}" ]; then')
            data_list.append(f'        ln -snf {server.file.start} start.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.file.stop}" ]; then')
            data_list.append(f'        ln -snf {server.file.stop} stop.sh')
            data_list.append(f'    fi')
            data_list.append(f'    if [ -f "{server.stop_script}" ]; then')
            data_list.append(f'        ln -snf {server.stop_script} stop.sh')
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
    data_list.append(f'fi')

    edited_symlink = '\n'.join(data_list) + '\n'
    write_file('output/scripts/others/create-symlink.sh', edited_symlink)


def create_add_host_script_file(server_dict):
    data_list = [
        f'#!/bin/bash\n',
        f'cat <<EOF | sudo tee -a /etc/hosts'
    ]

    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'{server.host_address} {server.host_name}')

    data_list.append(f'EOF')
    edited_hosts = '\n'.join(data_list) + '\n'
    write_file('output/scripts/others/add-hosts.sh', edited_hosts)


def create_secure_copy_script_file(base, server_dict):
    data_list = [
        f'#!/bin/bash\n',
        f'tar -czf confluent-properties.tar.gz ../../properties/*',
        f'tar -czf confluent-scripts.tar.gz ../../scripts/*',
        f'# tar -czf confluent-properties.tar.gz properties/*',
        f'# tar -czf confluent-scripts.tar.gz scripts/*\n'
    ]

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
            data_list.append(f'# scp confluent-properties.tar.gz '
                             f'{base.user}@{server.host_address}:{base.confluent_home}')

    data_list.append(f'')
    for server_type, servers in server_dict.items():
        for server in servers:
            data_list.append(f'# scp confluent-scripts.tar.gz '
                             f'{base.user}@{server.host_address}:{base.confluent_home}')

    edited_hosts = '\n'.join(data_list) + '\n'
    write_file('output/scripts/others/scp-files.sh', edited_hosts)


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
    write_file('output/scripts/others/.kafka_aliases', edited_hosts)
