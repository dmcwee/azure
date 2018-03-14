param (
    [string] $Url,
    [string] $CertCommonName,
    [string] $NetBiosName,
    [string] $GmsaName = "gMSAadfs$",
    [string] $CertificatePath = ""
)

if([string].IsNullOrEmpty($CertificatePath) -ne $true) {
    #install the certificate that will be used for ADFS Service
    $certPassword = Get-Credential -Message "PFX Password" -UserName "Enter the password"
    Import-PfxCertificate -Exportable -Password $certPassword.Password -CertStoreLocation cert:\localmachine\my -FilePath $CertificatePath
}
$cert = Get-ChildItem -Path Cert:\LocalMachine\my | Where-Object { $_.Subject -like $certCommonName } 


$kdsRootKey = Get-KdsRootKey -ErrorAction SilentlyContinue
if($kdsRootKey -eq $null){
    Write-Host "KDS Root Key does not exist, creating it now"
    Add-KdsRootKey -EffectiveTime (Get-Date).AddHours(-10)
}

#Configure ADFS Farm
Install-AdfsFarm -CertificateThumbprint $($cert.Thumbprint) -FederationServiceName $Url -GroupServiceAccountIdentifier $($NetBiosName + "\" + $GmsaName)