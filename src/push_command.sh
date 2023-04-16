ARCH=$(get_system_arch)
generate_dockerfile
docker build -t "${IMAGE_NAME}:${ARCH}"-latest -f ${DOCKERFILE} .
rm ${DOCKERFILE}
docker push "${IMAGE_NAME}:${ARCH}"-latest
