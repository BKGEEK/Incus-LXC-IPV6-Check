#!/bin/bash

# ipv6-log.sh - 查看所有 Incus 实例的 eth1 网卡公网 IPv6 地址

echo "正在获取所有 Incus 实例的 eth1 公网 IPv6 地址..."
echo "=============================================="

for instance in $(incus list --format csv -c n); do
    echo -n "$instance: "
    incus exec "$instance" -- ip -6 addr show dev eth1 2>/dev/null | grep 'inet6' | grep -v 'fd' | grep -v 'fe80::' | awk '{print $2}' | cut -d'/' -f1 || echo "No eth1 or no IPv6"
done

echo "=============================================="
echo "扫描完成！"
