. $PSScriptRoot\hash.ps1

Describe "Get-ShortHash" {

    It 'Converts long hash to 7-hex digits' {
        $hash = 'ca146ab02b483ad5f9ac079e64b6957509asdf'
        Get-ShortHash -Hash $hash | 
            Should Be 'ca146ab'
    }

}