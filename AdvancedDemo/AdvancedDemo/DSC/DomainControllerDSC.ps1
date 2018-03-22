Configuration Main
{

Param ( [string] $nodeName, [string] $driveLetter = "L", [PSCredential] $adminAccount )

Import-DscResource -ModuleName PSDesiredStateConfiguration

Node $nodeName
  {
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

	  Script Drives {
		  SetScript = {
			Stop-Service -Name ShellHWDetection

			Start-Sleep 2
			
			Get-Disk | 
			Where-Object partitionstyle -eq 'raw' | 
			Initialize-Disk -PartitionStyle MBR -PassThru | 
			New-Partition -DriveLetter $driveLetter -UseMaximumSize | 
			Format-Volume -FileSystem NTFS -NewFileSystemLabel "ADData" -Confirm:$false
			
			Start-Sleep 2
			
			Start-Service -Name ShellHWDetection
		  }
		  GetScript = {
			  @{ Result = (Get-Disk | Where-Object PartitionStyle -eq 'raw') }
		  }
		  TestScript = {
			  if((Get-Disk | where-object PartitionStyle -eq 'raw') -eq $null) {
				  return $false
			  }
			  else {
				  return $true
			  }
		  }
	  }

	  <#
	  Script DomainSetup {
		  DependsOn = "[WindowsFeature]ADDomainServices", "[WindowsFeature]DNS", "[WindowsFeature]ADTools", "[Script]Drives"
		  SetScript = {
			$dbPath = $driveLetter + ":\AD\NTDS\DB"
			$logPath = $driveLetter + ":\AD\NTDS\Log"
			$sysVol = $driveLetter + ":\AD\SYSVOL"

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
		  }
		  GetScript = {
			@{ Result = (Test-Path $($driveLetter + ":\AD\NTDS\DB")) }
		  }
		  TestScript = {
			  return $(Test-Path $($driveLetter + ":\AD\NTDS\DB"))
		  }
	  }
	  #>
  }
}