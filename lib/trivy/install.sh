#!/usr/bin/env bash

set -eu -o pipefail
export SHELLOPTS

TRIVY_VERSION="${1}"

case "${TARGETARCH}" in
    amd64)
        # ${TARGETOS^} capitalizes the first letter, so that 'linux' becomes 'Linux'.
        download_uri="https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_${TARGETOS^}-64bit.tar.gz"
        ;;
    arm64)
        download_uri="https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_${TARGETOS^}-ARM64.tar.gz"
        ;;
    *)
        echo "Architecture '${TARGETARCH}' has no known Trivy download URI." >&2
        exit 1
        ;;
esac

curl "${download_uri}" \
    --fail-with-body \
    --location \
    --show-error \
    --silent \
| tar \
    --directory /usr/local/bin \
    --extract \
    --gzip
