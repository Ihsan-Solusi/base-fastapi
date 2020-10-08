#!/usr/bin/env bash

set -e

use_tag="ihsansolusi/base-fastapi:$NAME"
use_dated_tag="${use_tag}-$(date +%Y%m%d%H%M%S)"

bash scripts/build.sh

docker tag "$use_tag" "$use_dated_tag"

#bash scripts/docker-login.sh

docker push "$use_tag"
docker push "$use_dated_tag"