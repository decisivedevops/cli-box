# Function to install a tool
function install_tool {
  install_commands=$(echo "${2}" | sed "s#\${URL}#${1}#g")
  # Build app image
  printf 'RUN %s\n' "$install_commands" >>${DOCKERFILE}
}
