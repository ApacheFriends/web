#!/bin/bash -e
#It builds the xampp-htdocs tarballs per platform for XAMPP

set -Eeuo pipefail

AFDIR="$(cd "$(dirname "$0")/.." && pwd)"

TAG="${1:-$(date +%Y%m%d)}"


cd "$AFDIR"
for platform in linux osx windows stackman; do
    echo "Building XAMPP htdocs for $platform"
    rm -rf -- "$AFDIR/build-xampp-$platform"
    rm -rf -- "$AFDIR/xampp-htdocs-$platform"
    rm -rf -- "$AFDIR/xampp-htdocs-$platform-"*.tar.gz
    APP=xampp platform="$platform" bin/middleman build
    mv "build-xampp-$platform" "xampp-htdocs-$platform"
    tar -czvf "xampp-htdocs-$platform-$TAG.tar.gz" "xampp-htdocs-$platform"
done
