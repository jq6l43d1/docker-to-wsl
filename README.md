# docker-to-wsl

The repository provides instructions on creating a Docker image, starting a Docker container, exporting 
it, and importing it into WSL. The included readme details the necessary Linux commands for working with 
Docker, while the Windows-specific instructions for WSL are also covered. While it's possible to perform 
the Docker-related steps on Windows, this guide only covers the Linux approach.

## What does this Docker file do?

This Docker file builds a fairly simple example Docker image. It's based on whatever the latest LTS version
of Ubuntu and has the latest versions of the CLI tools for the 3 major cloud providers (Amazon, Azure, and Google).

## How do I go from a Docker file to a running WSL distro?

Follow these steps.

### Step 1 (Linux): Clone this repo

Open a terminal and change directories to the location where you want the repo to be stored.

```
cd ~/Somewhere
```

Clone this repo

```
git clone git@github.com:jq6l43d1/docker-to-wsl.git
```

### Step 2 (Linux): Build the Docker image.

In your terminal, change directories into the folder containing the repo you just cloned.

```
cd docker-to-wsl
```

Build the docker image using the following command.

```
docker build -t cloud-cli-os-image -f cloud-cli-os.Dockerfile .
```

### Step 3 (Linux): Run a container using the image you just built.

Run the following command.

```
docker run -dit --rm --name cloud-cli-os-container cloud-cli-os-image
```

### Step 4 (Linux): Export the image.

Run the following command.

```
docker export cloud-cli-os-container > cloud-cli-os-container.tar
```

Alternatively, if you want to compress your image to save space you could run the following
command (You will have to extract the file after you transfer it to your Windows computer). 

```
docker export cloud-cli-os-container | bzip2 > cloud-cli-os-container.tar.bz2
```

### Step 5 (Windows): Import the image into WSL.

If you don't already have a folder where you want to keep the file system for the distro,
create one. I like to create a folder called 'distros' in my user folder, then create another
folder within that with the name of the distro I'll be importing.

For example:

C:\Users\my-username\distros\cloud-cli-os\

Move the .tar file, or the .tar.bz2 file if you chose to use compression, over to
the folder where you want your imported filesystem to be on your Windows computer.
Extract the file if you chose to use compression. Open command prompt and change
directories to this location.

In this example the command would be:

```
cd C:\Users\my-username\distros\cloud-cli-os\
```

Import the image by running the following command:

```
wsl --import cloud-cli-os . cloud-cli-os-container.tar
```

If you get an error while importing the container into WSL, make sure their aren't any other
WSL distros running.

Run the following command to start the cloud-cli-os distro and start a shell.

```
wsl -d cloud-cli-os
```
