#!/usr/bin/env bash

usage() {
  echo -e "Usage:\n  ${0} [-v =5.6] [-r =$(pwd)] [-h] [-p]\n  -v: Version of php to run (5.4, 5.5, 5.6, 7)\n  -r: root folder of the application\n  -h: This info text";
}

while getopts v:r:h o; do
  case ${o} in
    v|--version)
      VERSION="$OPTARG"
      if [[ ${VERSION} =~ ^[0-9\.]{1,3}$ ]]; then
        shift 2
      else
        echo "Version must match 'X.Y' or 'X'. E.g. '5.6' or '7'"
        usage
        exit 1
      fi
      ;;
    r|--root)
      ROOT="$OPTARG"
      shift 2
      ;;
    h|--help)
      usage
      exit 0
      ;;
    :)
      usage
      exit 1
      ;;
esac
done

ROOT="${ROOT:="$(pwd)"}"
VERSION="${VERSION:="5.6"}"
CMD="${@}"

echo "Starting PHP ${VERSION} in '${ROOT}' with CMD: '${CMD}'"
docker run -itp 80:80 -p 443:443 -v "${ROOT}:${ROOT}:rw" -w "${ROOT}" php-env:${VERSION} ${CMD}
