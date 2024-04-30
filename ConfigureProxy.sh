for i in {1..30}
do
    sudo lsof /var/lib/dpkg/lock-frontend
    if [ $? -ne 0 ]; then
        sudo lsof /var/lib/apt/lists/lock
        if [ $? -ne 0 ]; then
            break
        fi
    fi
    sleep 10
done
    
apt-get install tinyproxy -y
echo -e 'User nobody\nGroup nobody\nPort 8888\nTimeout 600\nSyslog On\nLogLevel Info\nPidFile "/usr/local/var/run/tinyproxy/tinyproxy.pid"\nMaxClients 100\nAllow 127.0.0.1\nAllow ::1\nAllow 10.0.0.0/8\nViaProxyName "tinyproxy"' > /etc/tinyproxy/tinyproxy.conf
tinyproxy
