. $PSScriptRoot\New-DockerImage.ps1

Describe "New-DockerImage" {
    It "Calls docker with the correct parameters" {
        Mock Get-Version { '0.1.0-beta.20170213153025+ca146ab' }
        
        # guard mock
        Mock Build-DockerImage 

        # worker mock
        Mock Build-DockerImage -ParameterFilter { 
            $Tag -eq "nohwnd/calculator:0.1.0-beta.20170213153025+ca146ab" `
            -and $Path -eq '.'
        } 


        New-DockerImage -Name 'nohwnd/calculator' -Path '.'


        Assert-MockCalled Build-DockerImage -Times 1 -Exactly -ParameterFilter { 
            $Tag -eq "nohwnd/calculator:0.1.0-beta.20170213153025+ca146ab" `
            -and $Path -eq '.'
        }
    }
}