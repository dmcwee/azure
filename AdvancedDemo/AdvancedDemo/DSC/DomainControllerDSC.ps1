Configuration Main
{

Param ( [string] $nodeName )

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
	  }
  }
}