#! /bin/bash

#
# Installation script for CK packages.
#
# See CK LICENSE.txt for licensing details.
# See CK Copyright.txt for copyright details.
#
# Developer(s): Grigori Fursin, 2015
#

# PACKAGE_DIR
# INSTALL_DIR

export PACKAGE_NAME=lapack-3.7.1
export PACKAGE_NAME1=lapack

cd ${INSTALL_DIR}
cp ${PACKAGE_DIR}/${PACKAGE_NAME1}.tgz .
gzip -d ${PACKAGE_NAME1}.tgz
tar xvf ${PACKAGE_NAME1}.tar
rm ${PACKAGE_NAME1}.tar

export INSTALL_OBJ_DIR=${INSTALL_DIR}/obj
mkdir $INSTALL_OBJ_DIR

if [ "${CK_COMPILER_TOOLCHAIN_NAME}" != "" ] ; then
  TOOLCHAIN=$CK_COMPILER_TOOLCHAIN_NAME
else
  TOOLCHAIN=gcc
fi

 echo ""
 cd ${INSTALL_OBJ_DIR}
 cmake -G "Unix Makefiles" -DLAPACKE=YES -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} ${INSTALL_DIR}/${PACKAGE_NAME} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
 if [ "${?}" != "0" ] ; then
   echo "Error: Configuration failed in $PWD!"
   exit 1
 fi

 # Build
 echo ""
 echo "Building ..."
 echo ""
 cd ${INSTALL_OBJ_DIR}
 make $pj
  if [ "${?}" != "0" ] ; then
    echo "Error: Compilation failed in $PWD!" 
    exit 1
  fi

 # Install
 echo ""
 echo "Installing ..."
 echo ""

 make install
  if [ "${?}" != "0" ] ; then
    echo "Error: Compilation failed in $PWD!" 
    exit 1
  fi

