#!/bin/bash
# psptoolchain.sh by fjtrujy

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)" || exit 1
FP32_OVERRIDE="${SCRIPT_DIR}/../config/newlib-fp32.sh"
# Preserve a caller override before changing into the nested toolchain.
if [[ ! -f "${PSPDEV_CONFIG_OVERRIDE:-}" || ! "${PSPDEV_CONFIG_OVERRIDE}" -ef "${FP32_OVERRIDE}" ]]; then
  unset PSPDEV_FP32_USER_CONFIG_OVERRIDE
  if [[ -f "${PSPDEV_CONFIG_OVERRIDE:-}" ]]; then
    USER_CONFIG_DIR="$(cd "$(dirname "${PSPDEV_CONFIG_OVERRIDE}")" && pwd)" || exit 1
    export PSPDEV_FP32_USER_CONFIG_OVERRIDE="${USER_CONFIG_DIR}/$(basename "${PSPDEV_CONFIG_OVERRIDE}")"
  fi
fi
export PSPDEV_CONFIG_OVERRIDE="${FP32_OVERRIDE}"

## Download the source code.
REPO_URL="https://github.com/doodlewind/psptoolchain"
REPO_FOLDER="psptoolchain"
BRANCH_NAME="master"
if test ! -d "$REPO_FOLDER"; then
	git clone --depth 1 -b $BRANCH_NAME $REPO_URL && cd $REPO_FOLDER || { exit 1; }
else
	cd $REPO_FOLDER && git fetch origin && git reset --hard origin/${BRANCH_NAME} || { exit 1; }
fi

## Build and install.
./toolchain.sh || { exit 1; }
