[CmdletBinding(SupportsShouldProcess=$true)]

<# Custom Script for Windows #>
Write-Verbose "Stopping ShellHWDetection Service"
Stop-Service -Name ShellHWDetection

Start-Sleep 2

Write-Verbose "Initializing Disk, Creating Partition, and Formatting Volume"
Get-Disk | 
Where-Object partitionstyle -eq 'raw' | 
Initialize-Disk -PartitionStyle MBR -PassThru | 
New-Partition -DriveLetter L -UseMaximumSize | 
Format-Volume -FileSystem NTFS -NewFileSystemLabel "ADData" -Confirm:$false

Start-Sleep 2

Write-Verbose "Starting ShellHWDetection Service"
Start-Service -Name ShellHWDetection

Write-Verbose "Adding AD Domain Services and Management Tools"
Add-WindowsFeature -Name ad-domain-services -IncludeManagementTools

Write-Verbose "Adding DNS Services and Management Tools"
Add-WindowsFeature -Name DNS -IncludeManagementTools