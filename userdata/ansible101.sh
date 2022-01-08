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

title.print "Permit root login"
echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo '' > /root/.ssh/authorized_keys
echo -e "moutarde42\nmoutarde42" | passwd root
systemctl restart sshd

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

title.print "Configuring tmux and plik"
wget https://www.arnaudmorin.fr/tmux.conf -O /root/.tmux.conf
wget https://www.arnaudmorin.fr/plikrc -O /root/.plikrc
wget https://www.arnaudmorin.fr/plik -O /usr/local/bin/plik
chmod +x /usr/local/bin/plik
echo 'if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then tmux new-session -A -s ssh_tmux ;fi' >> /root/.bashrc

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
