BeforeAll { 
    Import-Module $PSScriptRoot\GitHubSummary.psm1 -Force
}

Describe 'Get-GitHubSummary' { 
    It 'Shows `pester/Pester 156 14 !25` summary' {
        Mock Invoke-RestMethod { throw "Do not call the real Invoke-RestMethod" } -ModuleName GitHubSummary

        # Invoke-RestMethod -Method GET -Authentication Bearer -Token $Token -Uri $uri 
        Mock Invoke-RestMethod -ParameterFilter { $Method -eq "GET" -and $Uri -like "*is:issue*" } -ModuleName GitHubSummary -MockWith {
            $issues = Get-Content "$PSScriptRoot\2022-28-01-pester-issues.json" | ConvertFrom-Json
            $issues 
        } 

        Mock Invoke-RestMethod -ParameterFilter { $Method -eq "GET" -and $Uri -like "*is:pr*" } -ModuleName GitHubSummary -MockWith {
            $prs = Get-Content "$PSScriptRoot\2022-28-01-pester-prs.json" | ConvertFrom-Json
            $prs
        } 

        Mock Invoke-RestMethod -ParameterFilter { $Method -eq "GET" -and $Uri -like "*notifications*" } -ModuleName GitHubSummary -MockWith {
            $notifications = Get-Content "$PSScriptRoot\2022-28-01-pester-notifications.json" | ConvertFrom-Json
            $notifications
        } 

        $token = ConvertTo-SecureString -AsPlainText "placeholder"

        $actual = Get-GitHubSummary -Repo "pester/Pester" -Token $token

        $actual | Should -BeExactly "pester/Pester 156 14 !25"
    }
}