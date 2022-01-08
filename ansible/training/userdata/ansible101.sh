#!/bin/bash

# Setup logging stdout + stderr to logfile
log_file="/var/log/postinstall.log"

function log_handler {
  while IFS='' read -r output; do
    echo $output
    echo "$(date) - $output" >> $log_file
  done
}

function title.print {
    local string="$1"
    local stringw=$((77 - $(wc -L <<< "$string")))
    echo ""
    echo "┌──────────────────────────────────────────────────────────────────────────────┐"
    echo -n "│ $string"
    for i in $(seq 1 ${stringw}); do echo -n " " ; done
    echo "│"
    echo "└──────────────────────────────────────────────────────────────────────────────┘"
    echo ""
}


exec &> >(log_handler)

title.print "Install some packages"

apt-get update

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    git \
    sshpass \
    tmux
#    nginx \

title.print "Install docker"

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

title.print "Clone ansible-training"

cd /root/
git clone https://github.com/arnaudmorin/trainings.git

title.print "Building docker image 'demo'"

cd /root/trainings/ansible/training/docker
docker build -t demo .

#NOTE(arnaud) commented because this is something I want the student to do
#title.print "Configuring nginx as reverse proxy"
#cp /root/ansible-training/conf/proxy.conf /etc/nginx/site-enabled/
#systemctl restart nginx

title.print "Starting demo container"
docker run -d -p 127.0.0.2:8080:8080 -p 127.0.0.2:2222:22 --name demo demo

title.print "Done"
