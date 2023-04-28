ARCH=$(get_system_arch)
docker run -it -v $HOME:/root --network host decisivedevops/cli-box:${ARCH}-latest zsh
