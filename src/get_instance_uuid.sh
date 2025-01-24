#!/bin/bash

# get_instance_uuid.sh

URL_METADATA="http://169.254.169.254/openstack/latest/meta_data.json"

OPENSTACK_METADATA=$(curl \
    --silent \
    "$URL_METADATA"
)

INSTANCE_UUID=$(
    echo "$OPENSTACK_METADATA" | \
    tr -d '"' | \
    tr -d ' \t\n\r' | \
    grep -o -E 'uuid:[0-9a-zA-Z-]+' | \
    awk -F":" '{ print $2 }'
)
