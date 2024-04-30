wget "https://github.com/qtdyj/arc_for_servers_scripts/blob/main/httpc-proxy" -O /opt/proxy/httpc-proxy
chmod +x /opt/proxy/httpc-proxy

echo -e 'allow:\n- *.his.arc.azure.com\n- gw.arc.azure.com\n - management.azure.com\n - login.microsoftonline.com' > /opt/proxy/proxy.conf
nohup /opt/proxy/httpc-proxy -b :8888 -c /opt/proxy/proxy.conf &> /dev/null &

