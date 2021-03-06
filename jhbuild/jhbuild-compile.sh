#!/bin/bash
#
# Create a JHBUILD_CONFIG file and write a content like this:
#
# $ cat JHBUILD_CONFIG
# JHBUILD_MESA_ROOT=/opt/mesa
# MESA_RESOURCES=""
#
# Then, you can use this script to set and build the JHBuild
# environment for a specific driver. For example, for i965, run:
#
# $ ./jhbuild-compile.sh i965

source ./jhbuild-helper.sh

if [ ! -d ${JHBUILD_MESA_ROOT}/jhbuild.git ]; then
    git clone git://git.gnome.org/jhbuild ${JHBUILD_MESA_ROOT}/jhbuild.git
fi
pushd ${JHBUILD_MESA_ROOT}/jhbuild.git && git pull
./autogen.sh --prefix=${JHBUILD_MESA_ROOT}/jhbuild-install && make && make install
popd
#${JHBUILD_MESA_ROOT}/jhbuild-install/bin/jhbuild -f ${FULL_BASE_PATH}/jhbuildrc-basic sysdeps --install
#${JHBUILD_MESA_ROOT}/jhbuild-install/bin/jhbuild -f ${FULL_BASE_PATH}/jhbuildrc-basic build -f --nodeps
${JHBUILD_MESA_ROOT}/jhbuild-install/bin/jhbuild -f ${FULL_BASE_PATH}/jhbuildrc-basic build --nodeps
