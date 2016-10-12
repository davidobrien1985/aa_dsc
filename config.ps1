Configuration trivialweb 
{ 
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName cChoco 
    Import-DscResource -ModuleName xNetworking

    Node "isvbox" {   

        cChocoInstaller installChoco 
        { 
            InstallDir = "C:/choco" 
        }

        WindowsFeature installIIS 
        { 
            Ensure="Present" 
            Name="Web-Server" 
        }

        xFirewall WebFirewallRulehttp
        { 
            Direction = "Inbound" 
            Name = "Web-Server-http-In" 
            DisplayName = "Web Server (http-In)" 
            Enabled = "True"
            Action = "Allow" 
            Protocol = "TCP" 
            LocalPort = "80" 
            Ensure = "Present" 
        }
        xFirewall WebFirewallRulehttps
        { 
            Direction = "Inbound" 
            Name = "Web-Server-https-In" 
            DisplayName = "Web Server (ThttpsCP-In)" 
            Enabled = "True"
            Action = "Allow" 
            Protocol = "TCP" 
            LocalPort = "443" 
            Ensure = "Present" 
        }
    }    
}