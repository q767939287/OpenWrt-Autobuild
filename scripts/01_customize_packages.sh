#!/bin/bash

set -ex

mkdir -p package/new

# Access Control
cp -rf ../immortalwrt-luci/applications/luci-app-accesscontrol package/new/

# ADBYBY Plus +
svn export -q https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-adbyby-plus package/new/luci-app-adbyby-plus
cp -rf ../immortalwrt-packages/net/adbyby package/new/

# arpbind
cp -rf ../immortalwrt-luci/applications/luci-app-arpbind package/new/

# AutoCore
cp -rf ../immortalwrt/package/emortal/autocore package/new/
# grant getCPUUsage access
sed -i 's|"getTempInfo"|"getTempInfo", "getCPUBench", "getCPUUsage"|g' package/new/autocore/files/generic/luci-mod-status-autocore.json

# automount
cp -rf ../immortalwrt/package/emortal/automount package/new/

# cpufreq
cp -rf ../immortalwrt-luci/applications/luci-app-cpufreq package/new/

# DDNS
cp -rf ../immortalwrt-packages/net/ddns-scripts_aliyun package/new/
cp -rf ../immortalwrt-packages/net/ddns-scripts_dnspod package/new/

# dnsmasq: add filter aaa option
cp -rf ../patches/910-add-filter-aaaa-option-support.patch package/network/services/dnsmasq/patches/
patch -p1 -i ../patches/dnsmasq-add-filter-aaaa-option.patch
patch -d feeds/luci -p1 -i ../../../patches/filter-aaaa-luci.patch

# Filetransfer
cp -rf ../immortalwrt-luci/applications/luci-app-filetransfer package/new/
cp -rf ../immortalwrt-luci/libs/luci-lib-fs package/new/

# FullCone
cp -rf ../immortalwrt/package/network/utils/fullconenat package/network/utils
cp -f ../immortalwrt/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch target/linux/generic/hack-5.4/
patch -d feeds/luci -p1 -i ../../../patches/fullconenat-luci.patch
cp -rf ../immortalwrt/package/network/config/firewall/patches package/network/config/firewall/

# IPSEC
svn export -q https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-ipsec-server package/new/luci-app-ipsec-server

# Kernel: fix IPv6 package drop when using software flow offload
# pick from https://github.com/openwrt/openwrt/pull/4849
curl -sSL https://github.com/openwrt/openwrt/raw/6eda2e2/target/linux/generic/hack-5.4/652-netfilter-always_check_dst.patch -o target/linux/generic/hack-5.4/652-netfilter-always_check_dst.patch

# OLED
svn export -q https://github.com/NateLol/luci-app-oled/trunk package/new/luci-app-oled

# OpenClash
svn export -q https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/new/luci-app-openclash
patch -p1 -i ../patches/kmod-inet-diag.patch

# Realtek R8125
cp -rf ../immortalwrt/package/kernel/r8125 package/new/

# Realtek RTL8152/RTL8153
cp -rf ../immortalwrt/package/kernel/r8152 package/new/

# Realtek R8168
cp -rf ../immortalwrt/package/kernel/r8168 package/new/

# Realtek RTL8811CU/RTL8821CU
cp -rf ../immortalwrt/package/kernel/rtl8821cu package/new/

# Realtek 8812BU/8822BU
cp -rf ../immortalwrt/package/kernel/rtl88x2bu package/new/

# Realtek RTL8192EU
cp -rf ../immortalwrt/package/kernel/rtl8192eu package/new/

# Release Ram
cp -rf ../immortalwrt-luci/applications/luci-app-ramfree package/new/

# Scheduled Reboot
cp -rf ../immortalwrt-luci/applications/luci-app-autoreboot package/new/

# SeverChan
svn export -q https://github.com/tty228/luci-app-serverchan/trunk package/new/luci-app-serverchan

# ShadowsocksR Plus+
svn export -q https://github.com/fw876/helloworld/trunk package/helloworld
svn export -q https://github.com/coolsnowwolf/packages/trunk/net/shadowsocks-libev package/helloworld/shadowsocks-libev
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/shadowsocks-libev
cp -rf ../immortalwrt-packages/net/dns2socks package/new/
cp -rf ../immortalwrt-packages/net/ipt2socks package/new/
cp -rf ../immortalwrt-packages/net/kcptun package/new/
cp -rf ../immortalwrt-packages/net/microsocks package/new/
cp -rf ../immortalwrt-packages/net/pdnsd-alt package/new/
cp -rf ../immortalwrt-packages/net/redsocks2 package/new/
# building ssr-libev with libmbedtls
patch -d package/helloworld -p1 -i ../../../patches/building-ssr-libev-with-libmbedtls.patch

# Traffic Usage Monitor
svn export -q https://github.com/brvphoenix/wrtbwmon/trunk/wrtbwmon package/new/wrtbwmon
svn export -q https://github.com/brvphoenix/luci-app-wrtbwmon/trunk/luci-app-wrtbwmon package/new/luci-app-wrtbwmon

# USB Printer
svn export -q https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-usb-printer package/new/luci-app-usb-printer

# vlmcsd
cp -rf ../immortalwrt-luci/applications/luci-app-vlmcsd package/new/
cp -rf ../immortalwrt-packages/net/vlmcsd package/new/

# xlnetacc
cp -rf ../immortalwrt-luci/applications/luci-app-xlnetacc package/new/

# Zerotier
cp -rf ../immortalwrt-luci/applications/luci-app-zerotier package/new/

# default settings and translation
cp -rf ../default-settings package/new/

# max conntrack
sed -i 's,16384,65536,g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# fix include luci.mk
find package/new/ -type f -name Makefile -exec sed -i 's,../../luci.mk,$(TOPDIR)/feeds/luci/luci.mk,g' {} +

exit 0
