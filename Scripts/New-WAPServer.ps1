param(
    [string]$Url,
    [string]$certCommonName,
    [string]$certPath = ""
)

if([string].IsNullOrEmpty($CertificatePath) -ne $true) {
    #install the certificate that will be used for ADFS Service
    $certPassword = Get-Credential -Message "PFX Password" -UserName "Enter the password"
    Import-PfxCertificate -Exportable -Password $certPassword.Password -CertStoreLocation cert:\localmachine\my -FilePath $CertificatePath
}
$cert = Get-ChildItem -Path Cert:\LocalMachine\my | Where-Object { $_.Subject -like $certCommonName } 

$creds = Get-Credential -Message "ADFS Administrator Account"
Install-WebApplicationProxy -FederationServiceTrustCredential $creds -CertificateThumbprint $($cert.Thumbprint) -FederationServiceName $url