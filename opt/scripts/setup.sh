#!/bin/bash

INSTALL="yum -y install"
REINSTALL="yum -y reinstall"

$INSTALL http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm
$INSTALL centos-release-scl

yum-config-manager --enable centos-sclo-rh-testing centos-sclo-sclo-testing

curl -sL https://rpm.nodesource.com/setup_10.x | bash -

$INSTALL awscli \
         cmake3 \
         devtoolset-9 \
         git \
         kde-l10n-Chinese \
         make \
         nodejs \
         rpm-build \
         wget \
         openssl-devel \
         bzip2-devel \
         libffi-devel \
         xz-devel \
         readline-devel \
         sqlite-devel \
         zlib-devel

$REINSTALL glibc-common
localedef -c -f GB18030 -i zh_CN zh_CN.GB18030

echo "source /opt/rh/devtoolset-9/enable" >> /etc/profile
echo "source /opt/rh/devtoolset-9/enable" >> /etc/bashrc

ln -s /usr/bin/cmake3 /usr/bin/cmake

mkdir /tmp/python
cd /tmp/python
wget https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tgz
tar xzf Python-3.7.7.tgz
cd Python-3.7.7
./configure --with-ensurepip=install --enable-optimizations --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
make install
cd /
rm -rf /tmp/python

pip3 install pipenv==2020.11.15

echo "127.0.0.1 local-test" >> /etc/hosts