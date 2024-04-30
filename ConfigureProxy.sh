mkdir ~/proxy/
wget "https://github.com/qtdyj/arc_for_servers_scripts/blob/main/httpc-proxy" -O ~/proxy/httpc-proxy
chmod +x ~/proxy/httpc-proxy

echo -e 'allow:\n- "*.his.arc.azure.com"\n- gw.arc.azure.com\n- management.azure.com\n- login.microsoftonline.com' > ~/proxy/proxy.conf
nohup ~/proxy/httpc-proxy -b :8888 -c ~/proxy/proxy.conf &> /dev/null &
