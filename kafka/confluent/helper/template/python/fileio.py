#!/usr/bin/env python

import os
import shutil

import jinja2
import yaml


# region reset_output


def reset_output_dir(current_dir):
    properties_output_dir = current_dir.joinpath('properties')
    scripts_output_dir = current_dir.joinpath('scripts')
    server_stop_scripts_output_dir = current_dir.joinpath('scripts/server-stop')
    server_log_scripts_output_dir = current_dir.joinpath('scripts/server-log')
    other_output_dir = current_dir.joinpath('scripts/others')

    if os.path.exists(properties_output_dir):
        shutil.rmtree(properties_output_dir)
    if os.path.exists(scripts_output_dir):
        shutil.rmtree(scripts_output_dir)

    os.mkdir(properties_output_dir)
    os.mkdir(scripts_output_dir)
    os.mkdir(server_stop_scripts_output_dir)
    os.mkdir(server_log_scripts_output_dir)
    os.mkdir(other_output_dir)


# endregion

# reagion read_write


def read_file(file_path):
    with open(file_path, 'r') as script_file:
        return script_file.read()


def read_yaml_file(file_path):
    env = jinja2.Environment(loader=jinja2.FileSystemLoader('.'), trim_blocks=False, lstrip_blocks=True)
    template = env.get_template('values.yaml')
    return yaml.safe_load(template.render())


def write_file(file_path, file_data):
    with open(file_path, 'w') as script_file:
        script_file.write(file_data)

# endregion
