#!/usr/bin/env bash

sed -i '1iServer = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
pacman -Sy base base-devel vim wget screen fish htop git pyenv btop --needed --noconfirm
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
date
sudo sed -i '1i\en_US.UTF-8 UTF-8\nzh_CN.UTF-8 UTF-8\nzh_TW.UTF-8 UTF-8\n' /etc/locale.gen
locale-gen
cat << "EOF" > /etc/locale.conf
LANG=en_US.UTF-8
EOF

cat << "EOF" > /etc/sysctl.d/bbr.conf
net.core.default_qdisc = cake
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_fastopen = 3
EOF

cat << "EOF" > /etc/sysctl.conf
net.core.default_qdisc = cake
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_fastopen = 3
EOF

sysctl -p
lsmod |grep bbr
echo -e "nameserver 223.5.5.5\nnameserver 114.114.114.114" > /etc/resolv.conf


sed -i 's/^#NTP=.*/NTP=ntp.aliyun.com/g; s/^#FallbackNTP=.*/FallbackNTP=ntp1.aliyun.com ntp2.aliyun.com ntp3.aliyun.com ntp4.aliyun.com ntp5.aliyun.com ntp6.aliyun.com ntp7.aliyun.com/g' /etc/systemd/timesyncd.conf
systemctl restart systemd-timesyncd.service
timedatectl set-ntp true
timedatectl show-timesync --all
timedatectl timesync-status

chsh -s /bin/fish
