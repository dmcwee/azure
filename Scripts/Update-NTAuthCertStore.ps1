param( [string]$CertExportFolder ) 

$certs = Get-ChildItem cert:/localmachine/ca
$certs | ForEach-Object { Export-Certificate -cert $_ -FilePath $($CertExportFolder + "\" + $_.Thumbprint + ".cer") }

$certFiles = Get-ChildItem $CertExportFolder | Where-Object { $_.Name -like "*.cer" }
$certFiles | ForEach-Object { write-host "certutil -dspublish -f $($_.FullName) NTAuthCA" }
#$certFiles | foreach { certutil -dspublish -f $($_.FullName) NTAuthCA }