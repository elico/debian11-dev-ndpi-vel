#!/usr/bin/env bash

set -e
set -x

LINUX_HEADERS="linux-headers-$(uname -r)"
LINUX_IMAGE="linux-image-$(uname -r)"
sed -e "s@##LINUX_IMAGE###@${LINUX_IMAGE}@g" -e "s@###LINUX_HEADERS###@${LINUX_HEADERS}@g" Dockerfile.in > Dockerfile

set +x
set +e
