#!/usr/bin/python3
import json
from os import environ as env
from sys import argv
from pathlib import Path


def create_property(file: Path, configuration: list):
    with file.open(mode='w') as property_file:
        for k, v in configuration.items():
            prop="{}={}\n".format(k, v)
            property_file.write(prop)


def generate_configs(configuration: Path, hostname, server_id):
    with configuration.open(mode='r') as config_file:
        config = json.load(config_file)

    config.update({"listeners": "PLAINTEXT://{}:9092".format(hostname)})

    if server_id:
        file_name="server-{}.properties".format(server_id)
        config.update({"broker.id": server_id})
    else:
        file_name="server.properties"

    kafka_site = Path(env['KAFKA_CONFIG']) / file_name
    create_property(file=kafka_site, configuration=config)


generate_configs(configuration=Path(argv[1]), hostname=argv[2], server_id=argv[3])
