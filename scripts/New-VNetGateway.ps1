param(
    $ResourceGroupName, 
    $Location, 
    $GatewayIpConfig = "ipconfig1",
    $GatewayPipName = "VNet-GWPip",
    $VNetName = "AdvDemoNet",
    $VpnClientAddressPool = "192.168.200.0/24")

<#
Reference: 
https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-point-to-site-rm-ps
#>

$gatewayName = $ResourceGroupName + "-gateway"

#Get VNet, Gateway Subnet, and Public IP which were created by the Resource Group Template
$vnet = Get-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name "GatewaySubnet" -VirtualNetwork $vnet
$pip = Get-AzureRmPublicIpAddress -Name $GatewayPipName -ResourceGroupName $ResourceGroupName
Write-Verbose "Successfully got VNet: $($vnet.Name) SubNet: $($subnet.Name) and PIP $($pip.Name)"

#Create an IPConfiguration Object
$ipconf = New-AzureRmVirtualNetworkGatewayIpConfig -Name $GatewayIpConfig -Subnet $subnet -PublicIpAddress $pip
Write-Verbose "Created new azure VNet IPConfig $($ipconf.Name) object"

#Create the VNet Gateway
$gateway = New-AzureRmVirtualNetworkGateway -Name $GatewayName -ResourceGroupName $ResourceGroupName `
-Location $Location -IpConfigurations $ipconf -GatewayType Vpn `
-VpnType RouteBased -EnableBgp $false -GatewaySku VpnGw1 -VpnClientProtocol "IKEv2"
Write-Verbose "Created the Gateway $($gateway.Name)"

#Update the Gateway with the VPN Client Address Pool
$gateway = Get-AzureRmVirtualNetworkGateway -ResourceGroupName $ResourceGroupName -Name $GatewayName
Set-AzureRmVirtualNetworkGateway -VirtualNetworkGateway $Gateway -VpnClientAddressPool $VpnClientAddressPool
Write-Verbose "Set Gateway $($gateway.Name) VPN Client Address Pool to $($gateway.VpnClientConfiguration.VpnClientAddressPool)"

#Create a Root to use with the Gateway
$subject = "CN=" + $ResourceGroupName + " Gatway RootCert"
$name = $gatewayName + "Cert"
Write-Verbose "Creating Certificate with Subject $subject"

$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature -Subject $subject -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign
Write-Verbose "Created Certificate $($cert.Subject)"

#Create a Child Certificate to use with the Gateway
$childSubject = "CN=" + $ResourceGroupName + " Gateway ChildCert"

$childCert = New-SelfSignedCertificate -Type Custom -KeySpec Signature -Subject $childSubject -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
Write-Verbose "Created Child Certificate $($childCert.Subject)"

#upload the certificate
$CertBase64 = [system.convert]::ToBase64String($cert.RawData)
#New-AzureRmVpnClientRootCertificate -Name $P2SRootCertName -PublicCertData $CertBase64

Add-AzureRmVpnClientRootCertificate -VpnClientRootCertificateName $name -VirtualNetworkGatewayname $gatewayName `
 -ResourceGroupName $ResourceGroupName -PublicCertData $CertBase64
Write-Verbose "Added Root Certificate $($cert.Subject) to Gateway $($gateway.Name)" 