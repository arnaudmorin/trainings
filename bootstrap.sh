#!/bin/bash
openstack server create \
    --key-name arnaud-ovh \
    --net Ext-Net \
    --image 'Debian 10' \
    --flavor d2-4 \
    --user-data userdata/ansible101.sh \
    --min 12 \
    --max 12 \
    isen
