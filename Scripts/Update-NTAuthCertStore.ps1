param( [string]$CertExportFolder ) 

$certs = Get-ChildItem cert:/localmachine/ca
$certs | foreach { Export-Certificate -cert $_ -FilePath $($CertExportFolder + "\" + $_.Thumbprint + ".cer") }

$certFiles = get-ChildItem $CertExportFolder | ? { $_.Name -like "*.cer" }
$certFiles | foreach { certutil -dspublish -f $($_.Name) NTAuthCA }
