param([string]$Domain = "fiveguysconsulting.com")

$ipId = (Get-NetAdapter).ifIndex
Set-DNSClientServerAddress -interfaceIndex $ipId -ServerAddresses ($PrimaryDns,$SecondaryDns)

Add-Computer -DomainName $domain