#!/usr/bin/env python

import argparse
import pathlib


def get_value_file():
    parser = argparse.ArgumentParser(description='Helper App')
    parser.add_argument('value_file',
                        nargs='?',
                        default='values.yaml',
                        help='Specify a YAML file (default: values.yaml)')
    args = parser.parse_args()
    value_file = pathlib.Path(args.value_file)
    return value_file
