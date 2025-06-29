#!/bin/bash

# 清理旧的文件
rm -rf openwrt/openwrt-24.10/aarch64_generic/*
rm -rf openwrt/openwrt-24.10/x86_64/*

# 下载不要的插件压缩包
wget -O - https://github.com/zhiern/openwrt-package/releases/download/openwrt-24.10-aarch64_generic/aarch64_generic.tar.gz | tar -xz -C openwrt/openwrt-24.10/aarch64_generic
wget -O - https://github.com/zhiern/openwrt-package/releases/download/Helloworld-openwrt-24.10-aarch64_generic/aarch64_generic.tar.gz | tar -xz -C openwrt/openwrt-24.10/aarch64_generic
wget -O - https://github.com/zhiern/openwrt-package/releases/download/linkease-openwrt-24.10-aarch64_generic/aarch64_generic.tar.gz | tar -xz -C openwrt/openwrt-24.10/aarch64_generic
wget -O - https://github.com/zhiern/openwrt-package/releases/download/openwrt-24.10-x86_64/x86_64.tar.gz | tar -xz -C openwrt/openwrt-24.10/x86_64
wget -O - https://github.com/zhiern/openwrt-package/releases/download/Helloworld-openwrt-24.10-x86_64/x86_64.tar.gz | tar -xz -C openwrt/openwrt-24.10/x86_64
wget -O - https://github.com/zhiern/openwrt-package/releases/download/linkease-openwrt-24.10-x86_64/x86_64.tar.gz | openwrt/openwrt-24.10/x86_64

# 生成索引文件
./ipkg-make-index.sh openwrt/openwrt-24.10/x86_64 > openwrt/openwrt-24.10/x86_64/Packages
./ipkg-make-index.sh openwrt/openwrt-24.10/aarch64_generic > openwrt/openwrt-24.10/aarch64_generic/Packages

# 
usign -S -m openwrt/openwrt-24.10/aarch64_generic/Packages -s my-private.key
usign -S -m openwrt/openwrt-24.10/x86_64/Packages -s my-private.key
gzip -9nc openwrt/openwrt-24.10/x86_64/Packages > openwrt/openwrt-24.10/x86_64/Packages.gz
gzip -9nc openwrt/openwrt-24.10/aarch64_generic/Packages > openwrt/openwrt-24.10/aarch64_generic/Packages.gz
