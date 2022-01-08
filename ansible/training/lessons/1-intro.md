
# Before starting
## Host and Demo
You are currently connected to a server which have docker installed.
We will call this server: `localhost`.

You also have a docker container running in the background.
We will call this container: `demo`.

You can check your containers with:
`docker ps`

During these lessons, you will be ask to use ansible to configure both `localhost` and `demo`

# Installation

Install ansible on `localhost`

```
apt-get install ansible
```

# First use

## Check install
Check if ansible is correctly installed (and the version you have):
```
ansible --version
```
```
ansible 2.7.7
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.7.3 (default, Jul 25 2020, 13:03:44) [GCC 8.3.0]

```

## Ad-hoc ping
Use the builtin `ping` module to do your first ad-hoc command:
```
ansible localhost -m ping
```
This should answer with `pong`, like this:
```
localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

Q: What happened behing the scene?

## Ad-hoc shell

The `shell` module is a very nice ansible builtin module that can be use to execute commands on a host, e.g. with localhost:
```
ansible localhost -m shell -a "hostname"
```
Result:
```
localhost | CHANGED | rc=0 >>
ansible101

```
Q: what command can you use to get the IP of your machine?

## Ad-hoc setup
The `setup`module is a builtin module that collects data (also known as `facts`) on hosts.
These data can then be used as variables in your future playbooks (we will see that later).

```
ansible localhost -m setup
```
```
# long list of variables
```

Q: using this module, what other command can you use to retrieve the ip of your host?

