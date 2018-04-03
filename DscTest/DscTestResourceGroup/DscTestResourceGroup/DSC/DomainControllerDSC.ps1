Configuration Main
{

Param ( [string] $nodeName, [string] $driveLetter = "L", [PSCredential] $adminAccount )

Import-DscResource -ModuleName PSDesiredStateConfiguration

Node $nodeName
  {
	  Script Drives {
		  SetScript = {
				Write-Verbose "Stopping ShellHWDetection Service"
				Stop-Service -Name ShellHWDetection

				#Start-Sleep 2
			
				Write-Verbose "Service Stopped, Performing Disk Detection and Initilization"
				Get-Disk | 
					Where-Object partitionstyle -eq 'raw' | 
					Initialize-Disk -PartitionStyle MBR -PassThru | 
					New-Partition -DriveLetter $driveLetter -UseMaximumSize | 
					Format-Volume -FileSystem NTFS -NewFileSystemLabel "ADData" -Confirm:$false
			
				Write-Verbose "Disk Initilization is complete, restarting ShellHWDetection Service"
				Start-Service -Name ShellHWDetection
		  }
		  GetScript = {
			  @{ Result = "Do Something" }
		  }
		  TestScript = {
			  if((Get-Disk | where-object PartitionStyle -eq 'raw') -eq $null) {
					Write-Verbose "Get-Disk Condition returned $null"
				  return $true
			  }
			  else {
					Write-Verbose "Get-Disk Condition returned something"
				  return $false
			  }
		  }
	  }

	  <#
	  WindowsFeature ADDomainServices {
		Name="AD-Domain-Services"
		Ensure="Present"
	  }

	  WindowsFeature DNS {
		Name="DNS"
		Ensure="Present"
	  }

	  WindowsFeature ADTools {
		Name="RSAT-AD-Tools"
		Ensure = "Present"
		IncludeAllSubFeature = $true
	  }
	  #>

	  Script DomainSetup {
		  DependsOn = "[Script]Drives"
		  SetScript = {
			$dbPath = $driveLetter + ":\AD\NTDS\DB"
			$logPath = $driveLetter + ":\AD\NTDS\Log"
			$sysVol = $driveLetter + ":\AD\SYSVOL"

			#Testing Code...
			New-Item -Path $($driveLetter + ":\") -Name "AD" -ItemType "directory"

			<#
			Install-ADDSForest -CreateDnsDelegation:$false `
				-SafeModeAdministratorPassword $adminAccount.Password
        		-DatabasePath $dbPath `
        		-DomainMode "Win2012" `
        		-DomainName $DomainName `
        		-DomainNetbiosName $NetBiosName `
        		-ForestMode "Win2012" `
        		-InstallDns:$true `
        		-LogPath $logPath `
        		-NoRebootOnCompletion:$false `
        		-SysvolPath $sysVol `
				-Force:$true
			#>
		  }
		  GetScript = {
			@{ Result = $($driveLetter + ":\AD") }
		  }
		  TestScript = {
			  return $(Test-Path $($driveLetter + ":\AD"))
		  }
	  }
  }
}