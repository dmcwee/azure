param(
    [Parameter(Mandatory=$true)][string] $DomainName, 
    [Parameter(Mandatory=$true)][string] $NetBiosName, 
    [string] $Disk = "L",
    [string] $PrimaryDns = "10.0.0.10",
    [string] $SecondaryDns = "10.0.0.11",
    [string] $SiteName = "Default-First-Site-Name",
    [switch]$FirstAd)

Write-Host "Adding AD Domain Services and Management Tools"
Add-WindowsFeature -Name ad-domain-services -IncludeManagementTools

Write-Host "Adding DNS Services and Management Tools"
Add-WindowsFeature -Name DNS -IncludeManagementTools

Write-Host "The next steps will cause you to loose connetion with the machine.  Get coffee and come back in 5 minutes."

$ipId = (Get-NetAdapter).ifIndex
Set-DNSClientServerAddress -interfaceIndex $ipId -ServerAddresses ($PrimaryDns,$SecondaryDns)

#$domainname = "" 
#$netbiosName = "NWTRADERS" 

Write-Host "Importing ADDSDeployment"
Import-Module ADDSDeployment

$dbPath = $Disk + ":\AD\NTDS\DB"
$logPath = $Disk + ":\AD\NTDS\Log"
$sysVol = $Disk + ":\AD\SYSVOL"

if($FirstAd){
    Write-Host "Installing ADDSForst for $DomainName"
    Install-ADDSForest -CreateDnsDelegation:$false `
        -DatabasePath $dbPath `
        -DomainMode "Win2012" `
        -DomainName $DomainName `
        -DomainNetbiosName $NetBiosName `
        -ForestMode "Win2012" `
        -InstallDns:$true `
        -LogPath $logPath `
        -NoRebootOnCompletion:$false `
        -SysvolPath $sysVol `
        -Force:$true
}
else {
    Write-Host "Installing Second AD Server for $DomainName"
    
    Install-ADDSDomainController -CreateDnsDelegation:$false `
        -DatabasePath $dbPath `
        -DomainName $DomainName `
        -InstallDns:$true `
        -LogPath $logPath `
        -NoGlobalCatalog:$false `
        -SiteName $SiteName `
        -NoRebootOnCompletion:$false `
        -SysvolPath $sysVol `
        -Force:$true
}