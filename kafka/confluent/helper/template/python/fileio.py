#!/usr/bin/env python

import os
import pathlib
import shutil

import jinja2
import yaml


# region reset_output


def reset_output_dir(current_dir):
    output_dir = current_dir.joinpath('output')
    output_sub_dirs = [
        'log4j',
        'others',
        'properties',
        'pssh/hosts',
        'scripts',
        'services'
    ]

    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)

    for sub_dir in output_sub_dirs:
        pathlib.Path(output_dir.joinpath(sub_dir)).mkdir(parents=True, exist_ok=True)


# endregion

# reagion read_write_yaml_file


def render_values_file(dir_path, file_name):
    rendered_file_name = 'rendered-values.yaml'

    env = jinja2.Environment(loader=jinja2.FileSystemLoader('template/jinja'),
                             trim_blocks=True, lstrip_blocks=True)
    template = env.get_template('value-template.yaml.j2')

    context = read_yaml_file(dir_path.joinpath(file_name))
    rendered_values = template.render(**context)

    write_file(dir_path.joinpath(rendered_file_name), rendered_values)
    return rendered_file_name


def read_yaml_file(file_path):
    with open(file_path, 'r') as script_file:
        try:
            read_data = yaml.safe_load(script_file)
            return read_data
        except yaml.YAMLError as exc:
            print('[ERROR] Error in configuration file!')
            print(exc)
            exit(1)

# endregion

# reagion read_write_file


def read_file(file_path):
    with open(file_path, 'r') as script_file:
        read_data = script_file.read()
        return read_data


def write_file(file_path, file_data):
    with open(file_path, 'w', newline='\n') as script_file:
        script_file.write(file_data)

# endregion
