ARCH=$(get_system_arch)
generate_dockerfile
docker build -t "${IMAGE_NAME}:${ARCH}"-latest -f "${DOCKERFILE}" .
rm "${DOCKERFILE}"

# Print prompt for user
readonly PROMPT="--------------------------------------------------------------------
You can access the CLI tools using the following Docker run command:

    ./cli-box start\
"
printf "%s\n" "${PROMPT}"
