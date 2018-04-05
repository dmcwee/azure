Write-Host "Stopping ShellHWDetection Service"
Stop-Service -Name ShellHWDetection

Start-Sleep 2

Write-Host "Initializing Disk, Creating Partition, and Formatting Volume"
Get-Disk | 
Where-Object partitionstyle -eq 'raw' | 
Initialize-Disk -PartitionStyle MBR -PassThru | 
New-Partition -DriveLetter L -UseMaximumSize | 
Format-Volume -FileSystem NTFS -NewFileSystemLabel "ADData" -Confirm:$false

Start-Sleep 2

Write-Host "Starting ShellHWDetection Service"
Start-Service -Name ShellHWDetection