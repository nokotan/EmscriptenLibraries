#!/bin/bash

RepositoryName="soundtouch"
RepositoryAddress="https://gitlab.com/soundtouch/soundtouch.git"
RepositoryLicense="LGPL v2.1"

function init() {
    cd ${RepositoryDir}

    if [ ! -e "${RepositoryName}" ]; then
        git clone --depth 1 ${RepositoryAddress}
    fi

    cd ${RepositoryName}
    autoreconf -ifs
}

function build_wasm() {
    rm -rf build_wasm
    mkdir build_wasm
    cd build_wasm
    emconfigure ../configure --prefix=${SysRootDir} enable_static=yes enable_shared=no
    make install
}

function build_wasm_pic() {
    rm -rf build_wasm_pic
    mkdir build_wasm_pic
    cd build_wasm_pic
    emconfigure ../configure --prefix=${SysRootDir} CFLAGS='-fPIC' CXXFLAGS='-fPIC'
    make install
}

function build_asmjs() {
    rm -rf build_asmjs
    mkdir build_asmjs
    cd build_asmjs
    emconfigure ../configure --prefix=${SysRootDir}
    make install
}