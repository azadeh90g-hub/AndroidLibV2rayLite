#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"

# assets directory is preferred for gomobile and is already in .gitignore
DATADIR="${__dir}/assets"

# Display usage information
usage() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  download    Download geoip.dat and geosite.dat assets (default)"
    echo "  help, -h    Display this help message"
}

# Check for required dependencies
check_dependencies() {
    command -v go >/dev/null 2>&1 || { echo >&2 "Go is required but it's not installed. Aborting."; exit 1; }
    command -v curl >/dev/null 2>&1 || { echo >&2 "curl is required but it's not installed. Aborting."; exit 1; }
}

# Download data function
download_dat() {
    mkdir -p "$DATADIR"
    echo "Downloading assets to $DATADIR..."

    echo "Downloading geoip.dat..."
    curl --progress-bar -L https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -o "$DATADIR/geoip.dat"

    echo "Downloading geosite.dat..."
    curl --progress-bar -L https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -o "$DATADIR/geosite.dat"

    echo "Download complete! Assets are located in $DATADIR"
}

# Main execution logic
ACTION="${1:-download}"

case $ACTION in
    "download")
        check_dependencies
        download_dat
        ;;
    "help"|"-h"|"--help")
        usage
        ;;
    *)
        echo "Invalid action: $ACTION"
        usage
        exit 1
        ;;
esac
