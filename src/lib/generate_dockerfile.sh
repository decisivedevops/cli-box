# generate Dockerfile
function generate_dockerfile {
  # Define the Dockerfile contents as a variable
  DOCKERFILE_CONTENTS="
  FROM ${BASE_IMAGE}
  ${BASE_IMAGE_BUILD}
  "
  # Write the contents of the Dockerfile to a file
  printf "%s\n" "${DOCKERFILE_CONTENTS}" >${DOCKERFILE}

  # Install apps
  for app in $(yq e '.apps | keys | .[]' "${CONFIG_FILE}"); do
    url=$(yq e ".apps.${app}.${ARCH}_url" "${CONFIG_FILE}")
    replacements=$(yq e ".apps.${app}.replacements" "${CONFIG_FILE}")
    install_commands=$(yq e ".apps.${app}.install" "${CONFIG_FILE}")
    download_url=$(replace_variables "$url" "$replacements")
    install_tool "${download_url}" "${install_commands}"
  done
  after_build="
    COPY build/motd .
    COPY build/starship/ .
    COPY build/zsh/ .
    COPY build/tmux/ .
    WORKDIR /root
    "
  # Write the contents of the Dockerfile to a file
  printf "%s\n" "${after_build}" >>${DOCKERFILE}
}
