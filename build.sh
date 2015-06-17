#!/bin/bash

# https://buildkite.com/docs/guides/writing-build-scripts
set -eo pipefail

echo "+++ relaunching container"
docker stop friday_release \
    && docker rm friday_release \
    && docker run \
        --detach=true \
        --name=friday_release \
        -e VIRTUAL_HOST=shouldireleaseonafriday.com \
        chizcw/releasefriday
