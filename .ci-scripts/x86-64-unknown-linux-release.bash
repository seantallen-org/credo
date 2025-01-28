#!/bin/bash

# x86-64-unknown-linux release:
#
# - Builds release package
#
# Tools required in the environment that runs this:
#
# - bash
# - GNU gzip
# - GNU make
# - ponyc (musl based version)
# - GNU tar

set -o errexit

# Pull in shared configuration specific to this repo
base=$(dirname "$0")
# shellcheck source=.ci-scripts/release/config.bash
source "${base}/config.bash"

# Verify ENV is set up correctly
# We validate all that need to be set in case, in an absolute emergency,
# we need to run this by hand. Otherwise the GitHub actions environment should
# provide all of these if properly configured
if [[ -z "${APPLICATION_NAME}" ]]; then
  echo -e "\e[31mAPPLICATION_NAME needs to be set."
  echo -e "\e[31mExiting.\e[0m"
  exit 1
fi

# no unset variables allowed from here on out
# allow above so we can display nice error messages for expected unset variables
set -o nounset

# Compiler target parameters
ARCH=x86-64

# Triple construction
VENDOR=unknown
OS=linux
TRIPLE=${ARCH}-${VENDOR}-${OS}

# Build parameters
BUILD_PREFIX=$(mktemp -d)
APPLICATION_VERSION=$(cat VERSION)
BUILD_DIR=${BUILD_PREFIX}/${APPLICATION_VERSION}

# Asset information
PACKAGE_DIR=/tmp
PACKAGE=${APPLICATION_NAME}-${TRIPLE}

# Build application installation
echo -e "\e[34mBuilding ${APPLICATION_NAME}...\e[0m"
make install prefix="${BUILD_DIR}" arch=${ARCH} \
  version="${APPLICATION_VERSION}" static=true linker=bfd

# Asset information
ASSET_FILE=${PACKAGE_DIR}/${PACKAGE}.tar.gz

# Package it all up
echo -e "\e[34mCreating ${ASSET_FILE}\e[0m"
pushd "${BUILD_PREFIX}" || exit 1
tar -cvzf "${ASSET_FILE}" -- *
popd || exit 1
