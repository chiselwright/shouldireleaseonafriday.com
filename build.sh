#!/bin/bash

# https://buildkite.com/docs/guides/writing-build-scripts
set -eo pipefail

echo "+++ relaunching container"
docker stop friday_release ||true;
docker rm friday_release   ||true;
docker run \
    --detach=true \
    --name=friday_release \
    -e VIRTUAL_HOST=shouldireleaseonafriday.com \
    chizcw/releasefriday

echo "+++ listing most recent container"
docker ps -n=1

echo "--- listing all containers"
docker ps
