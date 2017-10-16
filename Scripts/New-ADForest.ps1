param($DomainName, $Password)

$PWD = ConvertTo-SecureString -AsPlainText $Password -Force
#$DomainName = "corpnet.org"
#if($PartnerNet) {
#	$DomainName = "extnet.org"
#}

Import-Module ServerManager
Add-windowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName $DomainName -SafeModeAdministratorPassword $PWD -DomainMode 5 -ForestMode 5 -InstallDNS -Force	