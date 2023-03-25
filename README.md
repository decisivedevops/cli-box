# cli-box

`cli-box` is a bash script that builds a Docker image with a preconfigured environment for CLI tools.

## Description

`cli-box` simplifies the setup of a preconfigured environment for CLI tools. It downloads and installs the necessary tools and dependencies and builds a Docker image, allowing for a consistent environment across different systems.

The script uses a configuration file in YAML format, where you can specify the base image, the tools to install, and their installation commands. The Dockerfile used to build the image is generated dynamically based on the configuration.

## Features

- Allows you to manage your CLI tools in a centralized configuration file.
- Ensures consistent environments for your CLI tools across systems.
- Allows easy version control of CLI tools.
- Lets you use the CLI tools without cluttering your system.
- Offers a simple solution using Docker.

## Requirements

To build `cli-box`, you need to have `Docker` and `yq` installed on your system. Here's how to install them:
### Docker

Follow the instructions on the [Docker website](https://docs.docker.com/engine/install/) to install Docker on your system.
### yq

`yq` is a command-line YAML processor that `cli-box` uses to parse the configuration file. Follow the instructions on the [yq website](https://github.com/mikefarah/yq#install) to install `yq` on your system.

## Usage
- Clone this repository on your local machine.
```bash
git clone https://github.com/decisivedevops/cli-box.git
```

- `cd` into the cloned directory.
```bash
cd cli-box
```

- To build `cli-box`, simply run the script:
```bash
./cli-box.sh
```
- This will build a Docker image using the configuration file [config.yaml](config.yaml).
- Once the Docker image is build, you can access the Docker shell and installed CLI tools using:

```bash
docker run -it -v $HOME:/root --network host decisivedevops/cli-box zsh
```

- To persist the config files for CLI tools, local `$HOME` directory is mounted as a volume inside the Docker container at `/root`.
- Also, `--network host` runs the container on the same network as host.

## Configuration

`cli-box` uses a configuration file in YAML format to specify the base image, the tools to install, and their installation commands. Here's an example configuration file:


```yaml
image_name: decisivedevops/cli-box:latest

base_image: bitnami/minideb:buster
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
- `image_name`: the name and tag of the Docker image to build.
- `base_image`: the base image to use for the Docker image.
- `base_image_build`: the commands to run on the base image before installing the tools.
- `apps`: a list of tools to install, with their installation commands and URLs for different architectures.
	- `replacements`: a list of variable replacements to apply to the URLs.
	- `<arch>_url`: the URL for the tool for a specific architecture.
	  - `linux/arm64` and `linux/amd64` supported
	  - This architecture is detected based on the local system's architecture.
	    - For example, If you are running this on `Apple M series` processors, `arm64` url is used and for `Intel` based machines, `amd64` url used.
	- `install`: the installation commands for the tool.

You can add more tools in this configuration file to suit your needs. [Here](APPLIST.md) is a list of the current CLI tools configured.
## Contributing

If you find a bug or have a feature request, please open an issue or submit a pull request.
## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
