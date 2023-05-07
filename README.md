<p align="center">
    <h1 align="center">📦 cli-box</h1>
</p>

<p align="center">
cli-box is a bash script that builds a Docker image with a preconfigured environment for CLI tools.
</p>

<p align="center">
    <img src="./assets/cli-box.jpg" width="300" height="300"/>
</p>

## Table of Contents
<!--ts-->
* [cli-box](#-cli-box)
   * [Description](#description)
   * [Features](#features)
   * [Usage](#usage)
   * [Build](#build)
      * [Requirements](#requirements)
      * [Command Lines Options](#command-lines-options)
      * [Build Steps](#build-steps)
   * [Configuration](#configuration)
         * [Configuration Syntax](#configuration-syntax)
   * [Contributing](#contributing)
   * [License](#license)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->
<!-- Added by: abhinav, at: Sun May  7 11:01:00 IST 2023 -->

<!--te-->

## Description

`cli-box` simplifies the setup of a preconfigured environment for CLI tools. It downloads and installs the necessary tools and dependencies and builds a Docker image, allowing for a consistent environment across different systems.

The script uses a configuration file in YAML format, where you can specify the base image, the tools to install, and their installation commands. The Dockerfile used to build the image is generated dynamically based on the configuration.

## Features

- Allows you to manage your CLI tools in a centralized configuration file.

- Ensures consistent environments for your CLI tools across systems.

- Allows easy version control of CLI tools.

- Lets you use the CLI tools without cluttering your system.

- Offers a simple solution using Docker.

## Usage

  - To access the `cli-box`, you can run the pre-built Docker images.
  - For `amd64`, `x86_64` system:

```bash
docker run -it -v $HOME:/root --network host decisivedevops/cli-box:amd64-latest zsh
```

- For `aarch64` , `arm64` system:

```bash
docker run -it -v $HOME:/root --network host decisivedevops/cli-box:arm64-latest zsh
```

  - To persist the config files for CLI tools, local `$HOME` directory is mounted as a volume inside the Docker container at `/root`.
  - Also, `--network host` runs the container on the same network as host.

>  [Here](APPLIST.md) is a list of the current CLI tools available.

## Build

### Requirements

To build and add your own tools to `cli-box`, you need to have `Docker` and `yq` installed on your system. Here's how to install them: [PREREQUISITES](PREREQUISITES.md)

### Command Lines Options

```
❯ ./cli-box -h
cli-box

  cli-box is a bash script that builds a Docker image with a preconfigured
  environment for CLI tools.

Usage:
  cli-box COMMAND
  cli-box [COMMAND] --help | -h
  cli-box --version | -v

Commands:
  start    Start cli-box Docker container
  build    Build the cli-box Docker image
  push     Build and push the cli-box Docker image to Docker registry
  update   Check for avialble updates for configured tools

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

```

### Build Steps

- Clone this repository on your local machine.
```bash
git clone https://github.com/decisivedevops/cli-box.git
```

- `cd` into the cloned directory.
```bash
cd cli-box
```
- You can update configuration file [config.yaml](config.yaml) to add tools you require.
- To build `cli-box`, simply run the script with `build` command:
```bash
./cli-box build
```

- Once the Docker image is build, the script outputs a command to access the CLI tools.

> Refer to [USAGE.md](USAGE.md) file to know how I am using the `cli-box` along with few other useful tools.

## Configuration

`cli-box` uses a configuration file in YAML format to specify the base image, the tools to install, and their installation commands. Here's an example configuration file:


```yaml
image_name: decisivedevops/cli-box
base_image: ubuntu:22.04
base_image_build: |
  apt update \
      && apt install -y ncurses-bin

apps:
  kubectl:
    changelog: https://kubernetes.io/releases/patch-releases/
    replacements: "VERSION=1.23.17 AMD64_OS=linux/amd64 ARM64_OS=linux/arm64"
    amd64_url: "https://storage.googleapis.com/kubernetes-release/release/v${VERSION}/bin/${AMD64_OS}/kubectl"
    arm64_url: "https://storage.googleapis.com/kubernetes-release/release/v${VERSION}/bin/${ARM64_OS}/kubectl"
    install: |
      curl -sSL ${URL} -o kubectl \
          && chmod +x kubectl \
          && mv kubectl /usr/local/bin/
```
#### Configuration Syntax
- `image_name`: the name of the Docker image to build.
- `base_image`: the base image to use for the Docker image.
- `base_image_build`: the commands to run on the base image before installing the tools.
- `apps`: a list of tools to install, with their installation commands and URLs for different architectures.
	- `replacements`: a list of variable replacements to apply to the URLs.
	- `<arch>_url`: the URL for the tool for a specific architecture.
	  - `linux/arm64` and `linux/amd64` supported
	  - This architecture is detected based on the local system's architecture.
	    - For example, If you are running this on `Apple M series` processors, `arm64` url is used and for `Intel` based machines, `amd64` url used.
	- `install`: the installation commands for the tool.

> You can add more tools in this configuration file to suit your requirements.

## Contributing

If you find a bug or have a feature request, please open an issue or submit a pull request.
## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
