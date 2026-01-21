#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"

DATADIR="${__dir}/data"

# Pinned version and checksums for security
RELEASE_VERSION="202601202217"
GEOIP_SHA256="1b205f743e042b1e0bd37b0010b2324854301415dbce598256bf307338e68c3a"
GEOSITE_SHA256="d02cd9d05c5d462be821bc067d6c0fb173f2083cef06642ad21ac7c72799d4dd"


# Check for required dependencies
check_dependencies() {
    command -v jq >/dev/null 2>&1 || { echo >&2 "jq is required but it's not installed. Aborting."; exit 1; }
    command -v go >/dev/null 2>&1 || { echo >&2 "Go is required but it's not installed. Aborting."; exit 1; }
    command -v sha256sum >/dev/null 2>&1 || { echo >&2 "sha256sum is required but it's not installed. Aborting."; exit 1; }
}


# Verify checksum function
verify_checksum() {
    local file_path=$1
    local expected_checksum=$2
    local calculated_checksum=$(sha256sum "$file_path" | awk '{print $1}')

    if [ "$calculated_checksum" != "$expected_checksum" ]; then
        echo "Checksum verification failed for $file_path."
        echo "Expected: $expected_checksum"
        echo "Got:      $calculated_checksum"
        exit 1
    fi
    echo "Checksum verified for $file_path"
}


# Download data function
download_dat() {
    mkdir -p "$DATADIR"

    echo "Downloading geoip.dat..."
    curl -sL "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$RELEASE_VERSION/geoip.dat" -o "$DATADIR/geoip.dat"
    verify_checksum "$DATADIR/geoip.dat" "$GEOIP_SHA256"


    echo "Downloading geosite.dat..."
    curl -sL "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/$RELEASE_VERSION/geosite.dat" -o "$DATADIR/geosite.dat"
    verify_checksum "$DATADIR/geosite.dat" "$GEOSITE_SHA256"
}

# Main execution logic
ACTION="${1:-download}"

check_dependencies

case $ACTION in
    "download") download_dat ;;
    *) echo "Invalid action: $ACTION" ; exit 1 ;;
esac
