#!/bin/bash
apt-get update
apt-get -y install python3-pip git
git clone https://github.com/arnaudmorin/demo-flask /opt/demo-flask
pip3 install -r /opt/demo-flask/requirements.txt
cp /opt/demo-flask/demo-flask.service /etc/systemd/system/
systemctl enable demo-flask.service
systemctl daemon-reload
systemctl start demo-flask.service
