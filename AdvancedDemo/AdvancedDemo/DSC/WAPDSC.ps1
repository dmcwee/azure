Configuration Main
{

Param ( [string] $nodeName )

Import-DscResource -ModuleName PSDesiredStateConfiguration

Node $nodeName
  {
	  WindowsFeature WAP {
		  Name="Web-Application-Proxy"
		  Ensure = "Present"
	  }
  }
}