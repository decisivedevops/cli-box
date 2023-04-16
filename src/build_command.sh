ARCH=$(get_system_arch)
generate_dockerfile
docker build -t "${IMAGE_NAME}:${ARCH}"-latest -f ${DOCKERFILE} .
rm ${DOCKERFILE}

# Print prompt for user
readonly PROMPT="--------------------------------------------------------------------
You can access the CLI tools using the following Docker run command:

docker run -it -v $HOME:/root --network host decisivedevops/cli-box:${ARCH}-latest zsh\
"
printf "%s\n" "${PROMPT}"
