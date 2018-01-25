param($CertName="AzureGateway")

$subject = "CN=" + $CertName + "RootCert"
Write-Verbose "Subject $subject"

$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature -Subject $subject -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

$childSubject = "CN=" + $CertName + "ChildCert"

New-SelfSignedCertificate -Type Custom -KeySpec Signature -Subject $childSubject -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
