# PREREQUISITES

## Install `Docker`

```bash
curl -fsSL https://get.docker.com | bash
```

## Install `yq`

### Get the latest version

```bash
LATEST_VERSION=$(curl -sL https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r ".tag_name")
```

### Install

  - For `amd64`, `x86_64` system:

```bash
curl -sSL https://github.com/mikefarah/yq/releases/download/${LATEST_VERSION}/yq_linux_amd64 -o /usr/bin/yq && chmod +x /usr/bin/yq
```

- For `aarch64` , `arm64` system:

```bash
curl -sSL https://github.com/mikefarah/yq/releases/download/${LATEST_VERSION}/yq_linux_arm64 -o /usr/bin/yq && chmod +x /usr/bin/yq
```