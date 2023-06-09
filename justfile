home_dir := env_var('HOME')

default:
    #!/usr/bin/env bash
    set -euxo pipefail
    case "$(uname -m)" in
        aarch64 | arm64) arch="arm64" ;;
        amd64 | x86-64 | x86_64) arch="amd64" ;;
        *) echo "Unsupported arch: ${ARCH}"; exit 1 ;;
    esac
    docker run -it -v {{justfile_directory()}}/home:/root -v {{home_dir}}:/mnt \
        --network host decisivedevops/cli-box:${arch}-latest zsh

tmux:
    #!/usr/bin/env bash
    set -euxo pipefail
    case "$(uname -m)" in
        aarch64 | arm64) arch="arm64" ;;
        amd64 | x86-64 | x86_64) arch="amd64" ;;
        *) echo "Unsupported arch: ${ARCH}"; exit 1 ;;
    esac
    docker run -it -v {{justfile_directory()}}/home:/root -v {{home_dir}}:/mnt \
        --network host decisivedevops/cli-box:${arch}-latest tmux -f /home/root/tmux.conf
