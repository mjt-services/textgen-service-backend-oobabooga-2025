#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/CONFIG"

ENV_FILE="${SCRIPT_DIR}/../.env"

docker run -d --name imagegen --gpus all \
-v ${MODELS_DIR}:/app/sd-webui/models  \
-v ${OUTPUTS_DIR}:/app/sd-webui/outputs \
-v ${VENDOR_DIR}:/app/sd-webui \
-it --rm -p:8888:8888 --env-file "${ENV_FILE}" "${IMAGE_TAG}"
