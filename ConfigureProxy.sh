#!/bin/bash

Interactive="$1"
DirPath="$2"

if [ "${Interactive,,}" != "true" ] && [ "${Interactive,,}" != "false" ]; then
	echo "Interactive must be set to either true or false."
	exit 1
fi

# Create directory for user proxy if needed
if [ -n "$DirPath" ]; then
    if [ ! -d "$DirPath" ]; then
        echo "$DirPath does not exist or is not a directory. Please run the script again with a valid directory path."
        exit 1
    fi
    MyProxyDir="$DirPath/MyProxy"
    echo "Configuring user proxy in $MyProxyDir"
else
    MyProxyDir="$HOME/MyProxy"
    echo "No path provided. Configuring user proxy in default location: $MyProxyDir"
fi

if [ ! -d "$MyProxyDir" ]; then
    mkdir -p "$MyProxyDir"
fi

ProxyConf="$MyProxyDir/myproxy.conf"
MyProxy="$MyProxyDir/myproxy"

wget -O "$MyProxy" "https://github.com/qtdyj/arc_for_servers_scripts/raw/main/httpc-proxy"

# Modify this line to update the allow list used by the proxy
cat <<EOF > "$ProxyConf"
allow:
- '*.his.arc.azure.com'
- '*gw.arc.azure.com'
- management.azure.com
- login.microsoftonline.com
EOF

chmod +x "$MyProxy"

if [ "${Interactive,,}" == "true" ]; then
	"$MyProxy" -b ":8888" -c "$ProxyConf"
else
	nohup "$MyProxy" -b ":8888" -c "$ProxyConf" &> /dev/null &
fi
