New-EventLog -LogName "Application" -Source "AddBgInfo"
Write-EventLog -LogName Application -Source "AddBgInfo" -EventId 0001 -Message "Starting Add-BgInfo.ps1 script"

Invoke-WebRequest -Uri "https://download.sysinternals.com/files/BGInfo.zip" -OutFile "$env:LOCALAPPDATA\bginfo.zip"
Write-EventLog -LogName Application -Source "AddBgInfo" -EventId 0002 -Message "Completed download of bginfo to $env:LOCALAPPDATA\bginfo.zip"

$key = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' -Name Startup
$value = $key.Startup
Write-EventLog -LogName Application -Source "AddBgInfo" -EventId 0003 -Message "BGInfo will unzip to $value"

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$env:LOCALAPPDATA\bginfo.zip", $value)
Write-EventLog -LogName Application -Source "AddBgInfo" -EventId 0004 -Message "Done unzipping bginfo.zip to $value"

New-Item -Path HKCU:\Software\Winternals\BGInfo -force
Write-EventLog -LogName Application -Source AddBgInfo -EventId 0005 -Message "Added BGInfo registry path"

Set-ItemProperty -path HKCU:\Software\Winternals\BGInfo -Name RTF -Value "{\rtf1\ansi\ansicpg1252\deff0\nouicompat\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}}
{\colortbl ;\red255\green255\blue255;}
{\*\generator Riched20 10.0.17763}\viewkind4\uc1 
\pard\fi-2880\li2880\tx2880\cf1\b\fs24 Boot Time:\tab\protect <Boot Time>\protect0\par
IP Address:\tab\protect <IP Address>\protect0\par
Logon Domain:\tab\protect <Logon Domain>\protect0\par
Logon Server:\tab\protect <Logon Server>\protect0\par
MAC Address:\tab\protect <MAC Address>\protect0\par
Machine Domain:\tab\protect <Machine Domain>\protect0\par
User Name:\tab\protect <User Name>\protect0\par
\par
}"

$cmd = $value + "\bginfo.exe"
. $cmd /timer:0