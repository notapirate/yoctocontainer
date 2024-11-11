#!/bin/bash
export SHELL=/bin/bash
export HOME=/yocto
export LANG=en_US.UTF-8
export POKY_DIR=${HOME}${POKY_DIR:-/sources/poky}
export BDIR=${HOME}${BDIR:-/build}
test -f ${HOME}/.gitconfig || \
(\
	git config --global --add user.name "John Doe"; \
	git config --global --add user.email johndoe@example.com; \
	git config --global init.defaultBranch master \
)
cd ${POKY_DIR}
. ./oe-init-build-env
exec "$@"
