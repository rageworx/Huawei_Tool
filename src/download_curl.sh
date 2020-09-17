#!/bin/bash

. download.conf

if [ ! -e ${DIRDEST} ];then
mkdir -p curl
fi

if [ ! -e ${DIRDEST} ];then
echo "Error: cannot access ${DIRDEST}"
exit 1
fi

# Donwload OpenSSL 1.1.1g
if [ ! -e ${DIRDEST}/${BINOPENSSL}.zip ];then
echo "Downloading ${BINOPENSSL}.zip ..."
wget ${BASEURL}/${BINOPENSSL}.zip -P ${DIRDEST}
fi

# Download brotli 1.0.8
if [ ! -e ${DIRDEST}/${BINBROTLI}.zip ];then
echo "Downloading ${BINBROTLI}.zip ..."
wget ${BASEURL}/${BINBROTLI}.zip -P ${DIRDEST}
fi

# Download libssh2 1.9.0
if [ ! -e ${DIRDEST}/${BINSSH2}.zip ];then
echo "Downloading ${BINSSH2}.zip ..."
wget ${BASEURL}/${BINSSH2}.zip -P ${DIRDEST}
fi

# Donwload libnghttp2 1.41.0
if [ ! -e ${DIRDEST}/${BINNGHTTP2}.zip ]; then
echo "Downloading ${BINNGHTTP2}.zip ..."
wget ${BASEURL}/${BINNGHTTP2}.zip -P ${DIRDEST}
fi

# Download libcurl 7.72.0
if [ ! -e ${DIRDEST}/${BINCURL}.zip ]; then
echo "Downloading ${BINCURL}.zip ..."
wget ${BASEURL}/${BINCURL}.zip -P ${DIRDEST}
fi

########################################################

# Extract Each zip files ...
if [ -e ${DIRDEST}/${BINOPENSSL}.zip ];then
echo "Extracting ${BINOPENSSL}.zip ..."
unzip -qq -o ${DIRDEST}/${BINOPENSSL}.zip -d ${DIRDEST}
fi

if [ -e ${DIRDEST}/${BINBROTLI}.zip ];then
echo "Extracting ${BINBROTLI}.zip ..."
unzip -qq -o ${DIRDEST}/${BINBROTLI}.zip -d ${DIRDEST}
fi

if [ -e ${DIRDEST}/${BINSSH2}.zip ];then
echo "Extracting ${BINSSH2}.zip ..."
unzip -qq -o ${DIRDEST}/${BINSSH2}.zip -d ${DIRDEST}
fi

if [ -e ${DIRDEST}/${BINNGHTTP2}.zip ];then
echo "Extracting ${BINNGHTTP2}.zip ..."
unzip -qq -o ${DIRDEST}/${BINNGHTTP2}.zip -d ${DIRDEST}
fi

if [ -e ${DIRDEST}/${BINCURL}.zip ]; then
echo "Extracting ${BINCURL}.zip ..."
unzip -qq -o ${DIRDEST}/${BINCURL}.zip -d ${DIRDEST}
fi

########################################################

echo "Done."
