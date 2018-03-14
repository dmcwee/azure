Configuration Main
{

Param ( [string] $nodeName )

Import-DscResource -ModuleName PSDesiredStateConfiguration

Node $nodeName
  {
	  WindowsFeature ADFS {
		  Name="ADFS-Federation"
		  Ensure = "Present"
		}
		
		WindowsFeature ADPowerShell {
			Name="RSAT-AD-PowerShell"
			Ensure = "Present"
		}
  }
}