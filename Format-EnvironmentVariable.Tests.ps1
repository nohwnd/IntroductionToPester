. $PSScriptRoot\Format-EnvironmentVariable.ps1

Describe 'Format-EnvironmentVariable' {
    It "Converts '<value>' to '<expected>'" -TestCases @(
        @{ Value = 'NugetVersion'; Expected = 'NUGET_VERSION' }
        @{ Value = 'ABC'; Expected = 'A_B_C' }
    ) {
        param($Value, $Expected)

        Format-EnvironmentVariable $Value |
            Should Be $Expected
    }

}