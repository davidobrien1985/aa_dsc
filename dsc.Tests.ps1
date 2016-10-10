Set-StrictMode -Version 4

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = 'config.ps1'
. "$here\$sut"

Describe "dsc" {
    
    Context 'tests if all DSC Resources are available' {
        It 'tests if PSDesiredStateConfiguration module is available' {
            Get-Module -Name PSDesiredStateConfiguration | Should be $true
        }
        It 'tests if cChocoInstaller resource is available' {
            Get-DscResource -Name cChocoInstaller | Should be $true
        }
        It 'test if xFirewall resource is available' {
            Get-DscResource -Name xFirewall | Should be $true
        }
    }
    Context 'DSC compilation tests' {
        It 'compiles the Configuration to a valid MOF' {
            {web -outputpath Testdrive:\} | Should not throw
        }
        It 'tests if the MOF actually exists' {
            {
                web -outputpath Testdrive:\
                Test-Path Testdrive:\localhost.mof
            } | Should be $true
        }
    }
}
