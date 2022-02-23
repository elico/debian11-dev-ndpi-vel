#!/usr/bin/env bash

set -e
set -x

DOCKER=`which docker`
PODMAN=`which podman`
if [ ! -z "${PODMAN}" ];then
	DOCKER="${PODMAN}"
fi

LINUX_HEADERS="linux-headers-$(uname -r)"
LINUX_IMAGE="linux-image-$(uname -r)"
sed -e "s@##LINUX_IMAGE###@${LINUX_IMAGE}@g" -e "s@###LINUX_HEADERS###@${LINUX_HEADERS}@g" Dockerfile.in > Dockerfile

if [ "$1" == "no-cache" ]; then
  ${PODMAN} build --no-cache -t local/debian11-ndpi .
else
  ${PODMAN} build -t local/debian11-ndpi .
fi

rm ./destdir -rf

${PODMAN} run -i -t -v `pwd`:/build/ local/debian11-ndpi

cd destdir
tar cvfJ xt_ndpi.tar.xz ./*
tar tvf xt_ndpi.tar.xz
cd -

set +x
