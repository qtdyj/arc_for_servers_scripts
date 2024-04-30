wget "https://github.com/qtdyj/arc_for_servers_scripts/blob/main/httpc-proxy" -O ./httpc-proxy
chmod +x ./httpc-proxy

echo -e 'allow:\n- *.his.arc.azure.com\n- gw.arc.azure.com\n - management.azure.com\n - login.microsoftonline.com' > ./proxy.conf
nohup ./httpc-proxy -b :8888 -c ./proxy.conf &> /dev/null &

