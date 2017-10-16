Write-Output "Issued To,Issued By,Certificate Store"

$rootconflicts = Get-ChildItem Cert:\LocalMachine\Root | Where-Object { $_.Issuer -ne $_.Subject }
$rootconflicts | ForEach-Object { 
    $subj = $_.SubjectName.Name.Split(",")[0].Split("=")[1]
    $issr = $_.Issuer.split(",")[0].Split("=")[1]
    Write-Output "$subj,$issr,Root"
}

$conflicts = Get-ChildItem Cert:\LocalMachine\CA | Where-Object { $_.Issuer -eq $_.Subject }
$conflicts | ForEach-Object { 
    $subj = $_.SubjectName.Name.Split(",")[0].Split("=")[1]
    $issr = $_.Issuer.split(",")[0].Split("=")[1]
    Write-Output "$subj,$issr,CA"
}

Write-Output "Found $($rootconflicts.Length) Non-Root Certificates in the Root Certificate Store."
Write-Output "Found $($conflicts.Length) Root Certificates in the Intermediate CA Store."