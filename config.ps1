Configuration trivialweb 
{ 
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName cChoco 
    Import-DscResource -ModuleName xNetworking

    Node "isvbox" {   

        cChocoInstaller installChoco 
        { 
            InstallDir = "C:\choco" 
        }

        WindowsFeature installIIS 
        { 
            Ensure="Present" 
            Name="Web-Server" 
        }

        xFirewall WebFirewallRule 
        { 
            Direction = "Inbound" 
            Name = "Web-Server-TCP-In" 
            DisplayName = "Web Server (TCP-In)" 
            Enabled = "True"
            Action = "Allow" 
            Protocol = "TCP" 
            LocalPort = "80" 
            Ensure = "Present" 
        }
    }    
}