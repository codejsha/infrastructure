#!/usr/bin/env python

from dataclasses import dataclass


@dataclass
class Base:
    user: str
    group: str
    confluent_home: str
    java_home: str
    properties_dir: str
    scripts_dir: str
