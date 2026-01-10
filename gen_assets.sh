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
}


# Download data function
download_dat() {
    echo "Fetching latest release information..."
    LATEST_RELEASE=$(curl -sL "https://api.github.com/repos/Loyalsoldier/v2ray-rules-dat/releases/latest")

    ASSETS=$(echo "$LATEST_RELEASE" | jq -r '.assets[] | {name, browser_download_url} | @base64')

    TMPDIR=$(mktemp -d)
    trap 'rm -rf -- "$TMPDIR"' EXIT

    for ASSET in $ASSETS; do
        DECODED_ASSET=$(echo "$ASSET" | base64 -d)
        NAME=$(echo "$DECODED_ASSET" | jq -r '.name')
        URL=$(echo "$DECODED_ASSET" | jq -r '.browser_download_url')

        if [[ "$NAME" == "geoip.dat" || "$NAME" == "geosite.dat" || "$NAME" == "geoip.dat.sha256sum" || "$NAME" == "geosite.dat.sha256sum" ]]; then
            echo "Downloading $NAME..."
            curl -sL "$URL" -o "$TMPDIR/$NAME"
        fi
    done

    echo "Verifying checksums..."
    (
        cd "$TMPDIR"
        sha256sum -c --strict geoip.dat.sha256sum
        sha256sum -c --strict geosite.dat.sha256sum
    )

    echo "Moving assets to $DATADIR..."
    mv "$TMPDIR/geoip.dat" "$DATADIR/geoip.dat"
    mv "$TMPDIR/geosite.dat" "$DATADIR/geosite.dat"

    echo "Download and verification complete."
}

# Main execution logic
ACTION="${1:-download}"

check_dependencies

case $ACTION in
    "download") download_dat ;;
    *) echo "Invalid action: $ACTION" ; exit 1 ;;
esac
