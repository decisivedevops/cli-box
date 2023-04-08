#!/bin/bash

set -euo pipefail  # Enable strict mode

# Config file path and Dockerfile path
readonly CONFIG_FILE="config.yaml"
readonly DOCKERFILE="Dockerfile.build"

# Get base image name, base image for build, and final image name from config file
readonly BASE_IMAGE="$(yq e '.base_image' "${CONFIG_FILE}")"
readonly BASE_IMAGE_BUILD="$(yq e '.base_image_build' "${CONFIG_FILE}")"
readonly IMAGE_NAME="$(yq e '.image_name' "${CONFIG_FILE}")"

# Detect the architecture of the system
case "$(uname -m)" in
aarch64 | arm64) readonly ARCH="arm64" ;;
amd64 | x86-64 | x86_64) readonly ARCH="amd64" ;;
*)
	echo "Unsupported arch: ${ARCH}" >&2
	exit 1
	;;
esac

# Define the Dockerfile contents as a variable
DOCKERFILE_CONTENTS="
FROM ${BASE_IMAGE}
${BASE_IMAGE_BUILD}
"

# Write the contents of the Dockerfile to a file
printf "%s\n" "${DOCKERFILE_CONTENTS}" >${DOCKERFILE}

# Function to install a tool
function install_tool {
	install_commands=$(echo "${2}" | sed "s#\${URL}#${1}#g")
	# Build app image
	printf 'RUN %s\n' "$install_commands" >>${DOCKERFILE}
}

# Function to replace variables in a string
function replace_variables {
	local str="$1"
	local replacements="$2"
	local varname varval
	for pair in ${replacements}; do
		IFS='=' read -r varname varval <<<"$pair"
		str=$(echo "$str" | sed "s#\${${varname}}#${varval}#g")
	done
	echo "$str"
}

# Main function
function main {
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
    # COPY build/fish/ /etc/fish/
    COPY build/zsh/ .
    COPY build/tmux/ .
    WORKDIR /root
    "
	# Write the contents of the Dockerfile to a file
	printf "%s\n" "${after_build}" >>${DOCKERFILE}

	docker build -t "${IMAGE_NAME}:${ARCH}"-latest -f ${DOCKERFILE} .
	rm ${DOCKERFILE}

	# Print prompt for user
	readonly PROMPT="
--------------------------------------------------------------------
You can access the CLI tools using the following Docker run command:

docker run -it -v $HOME:/root --network host decisivedevops/cli-box:${ARCH}-latest zsh
"
	printf "%s\n" "${PROMPT}"
}

# Call main function
main
