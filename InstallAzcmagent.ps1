$msiFile = Join-Path -Path "$env:Temp" -ChildPath "AzureConnectedMachineAgent.msi"
Invoke-WebRequest -Uri "https://aka.ms/AzureConnectedMachineAgent" -OutFile $msiFile

$logFile = Join-Path -Path "$env:Temp" -ChildPath "installationlog.txt"
$argList = @("/i", "$msiFile" , "/l*v", "$logFile", "/qn", "REBOOT=ReallySuppress")
$exitCode = (Start-Process -FilePath msiexec.exe -ArgumentList $argList -Wait -Passthru).ExitCode
$exitCode

if (! (Get-Command azcmagent -ErrorAction SilentlyContinue)) {
    $env:PATH="$($env:PATH);$($env:ProgramFiles)\AzureConnectedMachineAgent"
}

