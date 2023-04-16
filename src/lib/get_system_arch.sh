# Detect the architecture of the system
function get_system_arch {
  case "$(uname -m)" in
  aarch64 | arm64) readonly ARCH="arm64" ;;
  amd64 | x86-64 | x86_64) readonly ARCH="amd64" ;;
  *)
    echo "Unsupported arch: ${ARCH}" >&2
    exit 1
    ;;
  esac
  echo ${ARCH}
}
