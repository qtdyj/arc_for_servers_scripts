$msiFile = Join-Path -Path "$env:Temp" -ChildPath "AzureConnectedMachineAgent.msi"
# use version 1.40
Invoke-WebRequest -Uri "https://download.microsoft.com/download/2/1/0/210f77ca-e069-412b-bd94-eac02a63255d/AzureConnectedMachineAgent.msi" -OutFile $msiFile

$logFile = Join-Path -Path "$env:Temp" -ChildPath "installationlog.txt"
$argList = @("/i", "$msiFile" , "/l*v", "$logFile", "/qn", "REBOOT=ReallySuppress")
$exitCode = (Start-Process -FilePath msiexec.exe -ArgumentList $argList -Wait -Passthru).ExitCode
$exitCode

if (! (Get-Command azcmagent -ErrorAction SilentlyContinue)) {
    $env:PATH="$($env:PATH);$($env:ProgramFiles)\AzureConnectedMachineAgent"
}

