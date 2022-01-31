BeforeAll { 
    Import-Module $PSScriptRoot\GitHubSummary.psm1 -Force -PassThru
    ${function:Get-Prs} = InModuleScope -ModuleName GitHubSummary { Get-Command Get-Prs }
}

Describe 'Get-Prs' {
    BeforeAll { 
        Mock Invoke-RestMethod -ModuleName GitHubSummary
        $token = ConvertTo-SecureString -AsPlainText "placeholder"
    }

    It "Calls Invoke-RestMethod uses GET method" { 
        Get-Prs -Repo "pester/Pester" -Token $token

        Should -Invoke Invoke-RestMethod `
            -ModuleName GitHubSummary `
            -ParameterFilter { $Method -eq 'GET' } `
            -Exactly 1
    }

    It "Calls Invoke-RestMethod with the correct URL" {
        Get-Prs -Repo "pester/Pester" -Token $token

        Should -Invoke Invoke-RestMethod `
            -ModuleName GitHubSummary `
            -ParameterFilter { $Uri -eq "https://api.github.com/search/issues?q=repo:pester/Pester%20is:pr%20is:open" } `
            -Exactly 1
    }

    It "Passes token to Invoke-RestMethod" {
        Get-Prs -Repo "pester/Pester" -Token $token

        Should -Invoke Invoke-RestMethod `
            -ModuleName GitHubSummary `
            -ParameterFilter { $Token -eq $token } `
            -Exactly 1
    }
}