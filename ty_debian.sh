sudo sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
apt update -y && apt install screen fish nano -y
apt install systemd-timesyncd -y

sed -i 's/^#NTP=.*/NTP=ntp.aliyun.com/g; s/^#FallbackNTP=.*/FallbackNTP=ntp1.aliyun.com ntp2.aliyun.com ntp3.aliyun.com ntp4.aliyun.com ntp5.aliyun.com ntp6.aliyun.com ntp7.aliyun.com/g' /etc/systemd/timesyncd.conf
systemctl restart systemd-timesyncd.service
timedatectl set-ntp true
timedatectl show-timesync --all
timedatectl timesync-status

cat << "EOF" > /etc/sysctl.conf
net.core.default_qdisc = cake
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_fastopen = 3
EOF

sysctl -p
lsmod |grep bbr

chsh -s /usr/bin/fish
