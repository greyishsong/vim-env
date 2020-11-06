#!/bin/bash

$USER_HOME=$(python3 config.py default homepath)
if [ $USER_HOME = ""]; then
    echo "[error]Value \"homepath\" in local.conf is required to run script"
    exit 1
fi

apt install -y fontconfig
mkdir -p $USER_HOME/.config/fontconfig/conf.d
cp 50-enable-terminess-powerline.conf $USER_HOME/.config/fontconfig/conf.d
fc-cache -vf
