#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"

DATADIR="${__dir}/data"


# Check for required dependencies
check_dependencies() {
    command -v jq >/dev/null 2>&1 || { echo >&2 "jq is required but it's not installed. Aborting."; exit 1; }
    command -v go >/dev/null 2>&1 || { echo >&2 "Go is required but it's not installed. Aborting."; exit 1; }
    command -v sha256sum >/dev/null 2>&1 || { echo >&2 "sha256sum is required but it's not installed. Aborting."; exit 1; }
}


# Verify checksum function
verify_checksum() {
    local file_path="$1"
    local expected_checksum="$2"
    local calculated_checksum
    calculated_checksum=$(sha256sum "$file_path" | awk '{print $1}')

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
    local geoip_path="$DATADIR/geoip.dat"
    local geosite_path="$DATADIR/geosite.dat"
    GEOIP_SHA256="1b205f743e042b1e0bd37b0010b2324854301415dbce598256bf307338e68c3a"
    GEOSITE_SHA256="80638f667fa13ac512392485c532dbacfc9440ef66ee3e4b6b6985ed1b57a008"

    echo "Downloading geoip.dat..."
    curl -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o "$geoip_path"
    verify_checksum "$geoip_path" "$GEOIP_SHA256"

    echo "Downloading geosite.dat..."
    curl -sL https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o "$geosite_path"
    verify_checksum "$geosite_path" "$GEOSITE_SHA256"
}

# Main execution logic
ACTION="${1:-download}"

check_dependencies

case $ACTION in
    "download") download_dat ;;
    *) echo "Invalid action: $ACTION" ; exit 1 ;;
esac
