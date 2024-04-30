apt update
apt upgrade -y
apt-get install tinyproxy -y
echo -e 'User nobody\nGroup nobody\nPort 8888\nTimeout 600\nSyslog On\nLogLevel Info\nPidFile "/usr/local/var/run/tinyproxy/tinyproxy.pid"\nMaxClients 100\nAllow 127.0.0.1\nAllow ::1\nAllow 10.0.0.0/8\nViaProxyName "tinyproxy"' > /etc/tinyproxy/tinyproxy.conf
tinyproxy
