#!/usr/bin/env python

import os
import shutil

import jinja2
import yaml


# region reset_output


def reset_output_dir(current_dir):
    output_dir = current_dir.joinpath('output')
    properties_output_dir = current_dir.joinpath('output/properties')
    scripts_output_dir = current_dir.joinpath('output/scripts')
    server_stop_scripts_output_dir = current_dir.joinpath('output/scripts/server-stop')
    server_log_scripts_output_dir = current_dir.joinpath('output/scripts/server-log')
    server_grep_scripts_output_dir = current_dir.joinpath('output/scripts/server-grep')
    server_more_scripts_output_dir = current_dir.joinpath('output/scripts/server-more')
    other_scripts_output_dir = current_dir.joinpath('output/scripts/others')

    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)

    os.mkdir(output_dir)
    os.mkdir(properties_output_dir)
    os.mkdir(scripts_output_dir)
    os.mkdir(server_stop_scripts_output_dir)
    os.mkdir(server_log_scripts_output_dir)
    os.mkdir(server_grep_scripts_output_dir)
    os.mkdir(server_more_scripts_output_dir)
    os.mkdir(other_scripts_output_dir)


# endregion

# reagion read_write_yaml_file


def render_values_file(dir_path, file_name):
    rendered_file_name = 'rendered-values.yaml'

    with open(f'{dir_path}/{file_name}', 'r') as script_file:
        env = jinja2.Environment(loader=jinja2.FileSystemLoader('template/jinja'),
                                 trim_blocks=True, lstrip_blocks=True)
        template = env.get_template('value-template.yaml.j2')
        context = yaml.safe_load(script_file)
        rendered_values = template.render(**context)
        write_file(f'{dir_path}/{rendered_file_name}', rendered_values)

    return rendered_file_name


def read_yaml_file(file_path):
    with open(file_path, 'r') as script_file:
        read_data = yaml.safe_load(script_file)
        return read_data


# endregion

# reagion read_write_file


def read_file(file_path):
    with open(file_path, 'r') as script_file:
        read_data = script_file.read()
        return read_data


def write_file(file_path, file_data):
    with open(file_path, 'w') as script_file:
        script_file.write(file_data)

# endregion
