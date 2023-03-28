#!/bin/bash

# Exit immediately if any command exits with a non-zero status
set -e

# Config file path and Dockerfile path
config_file="config.yaml"
dockerfile="Dockerfile.build"

# Get base image name, base image for build, and final image name from config file
base_image=$(yq e '.base_image' "${config_file}")
base_image_build=$(yq e '.base_image_build' "${config_file}")
image_name=$(yq e '.image_name' "${config_file}")

# Detect the architecture of the system
case "$(uname -m)" in
    aarch64 | arm64) arch="arm64" ;;
    amd64 | x86-64 | x86_64) arch="amd64" ;;
    *) echo "Unsupported arch: ${ARCH}"; exit 1 ;;
esac

# Define the Dockerfile contents as a variable
build="
FROM ${base_image}
${base_image_build}
"

# Write the contents of the Dockerfile to a file
printf "%s\n" "${build}" >${dockerfile}

# Function to install a tool
function install_tool {
    binary_url=$(echo "${2}" | sed "s/\${VERSION}/${1}/g")
    install_commands=$(echo "${3}" | sed "s#\${URL}#${binary_url}#g")
    # Build app image
    printf 'RUN %s\n' "$install_commands" >>${dockerfile}
}

# Function to replace variables in a string
function replace_variables {
    local str="$1"
    local replacements="$2"
    local varname varval
    for pair in ${replacements}; do
        IFS='=' read -r varname varval <<< "$pair"
        str=$(echo "$str" | sed "s#\${${varname}}#${varval}#g")
    done
    echo "$str"
}

# Main function
function main {
    # Install apps
    for app in $(yq e '.apps | keys | .[]' "${config_file}"); do
        url=$(yq e ".apps.${app}.${arch}_url" "${config_file}")
        replacements=$(yq e ".apps.${app}.replacements" "${config_file}")
        install_commands=$(yq e ".apps.${app}.install" "${config_file}")
        download_url=$(replace_variables "$url" "$replacements")
        install_tool "${version}" "${download_url}" "${install_commands}"
    done
    after_build="
    COPY build/motd .
    COPY build/starship/ .
    COPY build/fish/ /etc/fish/
    COPY build/tmux/ .
    WORKDIR /root
    "
    # Write the contents of the Dockerfile to a file
    printf "%s\n" "${after_build}" >>${dockerfile}

    docker build -t ${image_name} -f ${dockerfile} .
    rm ${dockerfile}
}

# Call main function
main
