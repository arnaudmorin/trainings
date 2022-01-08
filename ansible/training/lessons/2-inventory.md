
# Inventory

Until now, you only used ansible to manage `localhost`.

But ansible can be used to manage multiple systems that you have in your infrastructure.
To do so, we must tell ansible which servers compose our infrastructure. This is done thanks to an `inventory` file.
The default `inventory` file for ansible is located in `/etc/ansible/hosts`.

```
cat /etc/ansible/hosts
```

It's empty by default (not really empty, but everything is commented).
With an empty `inventory` like that, ansible only knows about `localhost`.


## Demo server

### Add a server in your inventory

Add the following line at the end of your inventory:
```
demo ansible_username=root ansible_password=root ansible_connection=ssh ansible_host=127.0.0.2 ansible_port=2222 ansible_python_interpreter=/usr/bin/python3
```

This line adds our server named `demo` in ansible inventory. It also configure ansible to connect with login `root`, password `root` on port `2222`.
The server IP address is `127.0.0.2` which sound weird, but that's because it's a docker container running locally (for the demo).
Finally, we tell ansible to use `python3` interpreter (default is `python`, but it's not available in the demo server).

### Check if running
Try to connect on your demo machine, to see if it's running:
```
ssh -p 2222 root@127.0.0.2
```

### ping
Now use an ansible ad-hoc module to check if ansible is able to connect to this machine

```
ansible ...  # complete by yourself / see previous lessons
```


