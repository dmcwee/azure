<# Custom Script for Windows #>

Stop-Service -Name ShellHWDetection;

Start-Sleep 2;

Get-Disk | 
Where-Object partitionstyle -eq 'raw' | 
Initialize-Disk -PartitionStyle MBR -PassThru | 
New-Partition -DriveLetter L -UseMaximumSize | 
Format-Volume -FileSystem NTFS -NewFileSystemLabel "ADData" -Confirm:$false;

Start-Sleep 2;

Start-Service -Name ShellHWDetection;

Add-WindowsFeature -Name ad-domain-services -IncludeManagementTools;

Add-WindowsFeature -Name DNS -IncludeManagementTools;