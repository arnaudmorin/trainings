# Playbooks
Playbooks in Ansible are simple `YAML` file that describe configuration which should be done on a remote server.
Playbooks are really simple but very powerful; the tasks mentioned inside the playbook are execute sequentially.
`YAML` is human-readable data serialization format, which cares about whitespace like `Python`, it represents tree-like structure.

## First playbook

### Step 1
Create a file `myplaybook.yml` with the following content:

```
---
- hosts: demo
  gather_facts: yes
  tasks:
  - name: Install the git package
    apt: 
      name: git
      state: present
```
Here is the explanation of this playbook:

`- hosts: demo` is here to tell ansible that this part of the playbook should be applied on server `demo`
This playbook is very simple and apply only on `demo`, but you will often have playbooks that apply on multiple hosts. Ansible is great tool to orchestrate installation.

`gather_facts: yes` tells ansible to execute the `setup` module before doing anything else. The `setup` module will collects the `facts` and store them as variables. Those variables can then be used in playbooks. In this demo playbook, we dont use any variable yet, but you will see that later.

`tasks:`is a list of task that will be applied on the server. For now we only have one task, which is using the module `apt` to install the `git` package.

Now run the play:
```
ansible-playbook myplaybook.yml
```
After this, your `demo` server is supposed to have `git` installed.

### Step 2

Add a task to clone a flask application from github: `https://github.com/arnaudmorin/demo-flask.git`
(A flask application is a very simple web server written in python - so basically, it's a website)
```
---
- hosts: demo
  gather_facts: yes
  tasks:
  - name: Install the git package
    apt: 
      name: git
      update_cache: yes 
      state: present
  - name: Clone my flask application
    git: ...   # complete by yourself
               # see https://docs.ansible.com/ansible/latest/collections/ansible/builtin/git_module.html
```

### Step 3
Add a task to install the flask app.
Check the github page https://github.com/arnaudmorin/demo-flask for info on how this apps can be installed (but dont do it manually).
Then, add a task to your playbook that will do the installation for you.

### Step 4
Add a task to start the app in background.

### Step 5
Your `demo` server is now running the flask application.
Unfortunately, this is running in a docker container inside your `localhost`.
So the application is not yet accessible from internet.

What you should do now is to make this application accessible from internet!
By chance, the demo container is having port `8080` opened:
```
docker port demo
```
will give you:
```
8080/tcp -> 127.0.0.2:8080
22/tcp -> 127.0.0.2:2222
```

So, to access demo from internet, you will have to install a `proxy` server.
Here are some tips:
* Extend your playbook to not only manage `demo` but also `localhost`.
For `localhost`, add a least 2 tasks:
  * install nginx
  * configure nginx as a proxy (port 80 --> 8080) (google is your friend)
* Bonus: How can we restart nginx only after we changed it's configuration? (tip: ansibles handlers)
* Bonus2: using some ansible variables to add a debug task to your playbook to print the URL of your website.
