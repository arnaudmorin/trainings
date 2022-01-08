# Check your docker installation

Run the hello-world docker container to check if everything is fine.

```
docker run hello-world
```

# Using `debian` docker
You will now use the `debian` image.

So first, pull it from the docker hub

```
# Q: what command are you going to use to download locally the debian image?
your command
```

List the images

```
docker images
...
debian                   latest    6f4986d78878   2 weeks ago      124MB
...
```

Run your first docker image

```
docker run debian
```

Wait, nothing happened! Is that a bug? Well, no. Behind the scenes, a lot of stuff happened. 

When you call `run`, the Docker client finds the image (busybox in this case), loads up the container and then runs a command in that container.

When we run `docker run debian`, we didn't provide any command, so the container booted up, ran an empty command and then exited.
Well, yeah - kind of a bummer. Let's try something more exciting.

```
docker run debian echo "hello from debian!"
```
Nice - finally we see some output.
In this case, the Docker client dutifully ran the `echo` command in our `debian` container and then exited it.

Ok, now it's time to see the `docker ps` command.
The `docker ps` command shows you all containers that are currently running:
```
docker ps
CONTAINER ID   IMAGE     COMMAND               CREATED          STATUS          PORTS                                              NAMES
f9c03ce13b09   demo      "/usr/sbin/sshd -D"   32 minutes ago   Up 32 minutes   127.0.0.2:8080->8080/tcp, 127.0.0.2:2222->22/tcp   demo
```
So you see only one container running, named `demo`.
This is not your `debian` container, but the container used in the previous lesson.
Why the `debian` is not visible? Because it's not running anymore!

Q: what command can we use to retrieve all containers, including the stopped ones?

You're probably wondering if there is a way to run more than just one command in a container. Let's try that now:

```
docker run -it debian bash
/ # ls
bin  boot  dev	etc  home  lib	lib64  media  mnt  opt	proc  root  run  sbin  srv  sys  tmp  usr  var
```

Running the `run` command with the `-it` flags attaches us to an interactive tty in the container. Now we can run as many commands in the container as we want. Take some time to run your favorite commands.

It's now time to clean some of the old stopped containers to avoid filling your system with dead containers:
```
docker ps -a
# grab the ID of the containers you want to clean
docker rm xxyy
```

Q: which parameter to `docker run` could we pass to automate the removal of the container after the execution?

# Clean your environment
Before continuing this training, destroy all running containers using `docker stop` and `docker rm`. Destroy also the `demo` container from previous lesson, we don't need it anymore.

# Real application
It's now time to deploy a real application.
Once again, you will deploy the `demo-flask` application, but this time, by building a docker image of this application instead of installing it using `ansible`.

Start by cloning the app:
```
git clone https://github.com/arnaudmorin/demo-flask.git
cd demo-flask
```

Take a look at the `Dockerfile`:
```
vim Dockerfile
# to exit vim: <esc>:q
```
A [Dockerfile](https://docs.docker.com/engine/reference/builder/) is a simple text file that contains a list of commands that the Docker client calls while creating an image. It's a simple way to automate the image creation process.

There are a lot of different [commands](https://docs.docker.com/engine/reference/builder/#from) you can use in a `Dockerfile`.

Q: try to describe all the commands you see in this `Dockerfile`.

Close the `Dockerfile`.
It's now time to build our image. The `docker build` command does the heavy-lifting of creating a Docker image from a `Dockerfile`:

```
docker build -t yourname/demo-flask .
```


Start now a container from your image:
```
docker run yourname/demo-flask
```
This will start a container with the demo-flask, but the app will not be accessible from outside.

You remember that you installed a `nginx` proxy to access the previous `demo` container?

Q: find the good `docker run` command to run your container in background and expose the port locally so the `nginx` proxy reach your application.

Congrats, you're done with docker101!

