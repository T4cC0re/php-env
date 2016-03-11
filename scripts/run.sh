#!/usr/bin/env bash

usage() {
  echo -e "Usage:\n  ${0} <version> <workdir> <layers-up>\n  version: Version of php to run (5.4, 5.5, 5.6, 7)\n  workdir: workdir to mount and set\n  layers-up: Amount of folders upwards the tree to mount\n\nExample:\n  ${0} 5.6 /home/user/project 1 -a\nfor a php 5.6 interactive shell in /home/user/project with having /home/user mounted";
}

VERSION="${1}"
if [[ ${VERSION} =~ ^[0-9\.]{1,3}$ ]]; then
  shift
else
  echo "Version must match 'X.Y' or 'X'. E.g. '5.6' or '7'"
  usage
  exit 1
fi

ROOT="${1}"
shift

LAYERS="${1}"
if [ "${LAYERS}" != "0" ]; then
  for ((i=0; i<$LAYERS; i++)); do
    UPWARDS="${UPWARDS}../"
  done
fi
MOUNTROOT="$(realpath $(realpath ${ROOT})/${UPWARDS})"
echo $MOUNTROOT
shift

CMD="${@}"

#echo "Starting PHP ${VERSION} in '${ROOT}' with CMD: '${CMD}'"
docker run -ip 80:80 -p 443:443 -v "${MOUNTROOT}:${MOUNTROOT}:rw" -v "/tmp:/tmp:rw" -w "${ROOT}" php-env:${VERSION} ${CMD}
