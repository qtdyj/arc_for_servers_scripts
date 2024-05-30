param (
    [Parameter(Mandatory = $false)]
    [string]$DirPath
)

# Create directory for user proxy if needed
if ($DirPath) {
    if (-not (Test-Path -Path $DirPath)) {
        Write-Error "$($DirPath) does not exist. Please run the script again with a valid directory path."
        Exit 1
    } elseif (Test-Path -Path $DirPath -PathType Leaf) {
        Write-Error "$($DirPath) is not a directory path. Please run the script again with a valid directory path."
        Exit 1
    }
    $MyProxyDir = Join-Path -Path $DirPath -ChildPath "MyProxy"
    Write-Host "Configuring user proxy in $($MyProxyDir)"
} else {
    $MyProxyDir = Join-Path -Path $env:HOMEPATH -ChildPath "MyProxy"
    Write-Host "No path provided. Configuring user proxy in default location: $($MyProxyDir)"
}

if (-not (Test-Path -Path $MyProxyDir)) {
    New-Item -Path $MyProxyDir -ItemType "directory"
}

$ProxyConf = Join-Path -Path $MyProxyDir -ChildPath "myproxy.conf"
$MyProxy = Join-Path -Path $MyProxyDir -ChildPath "myproxy.exe"

Invoke-WebRequest -Uri "https://github.com/qtdyj/arc_for_servers_scripts/raw/main/httpc-proxy.exe" -OutFile $MyProxy

# Modify this line to update the allow list used by the proxy
"allow:`n- '*.his.arc.azure.com'`n- '*gw.arc.azure.com'`n- management.azure.com`n- login.microsoftonline.com" | Out-File -FilePath $ProxyConf

& $MyProxy -b ":8888" -c $ProxyConf
