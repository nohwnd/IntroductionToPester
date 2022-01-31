BeforeAll { 
    Import-Module $PSScriptRoot\GitHubSummary.psm1 -Force -PassThru
    ${function:ConvertTo-CamelCase} = InModuleScope -ModuleName GitHubSummary { Get-Command ConvertTo-CamelCase }
}

Describe 'ConvertTo-CamelCase' {
    It "Converts from name to Name" { 
        ConvertTo-CamelCase "name" | Should -Be "Name"
    }

    It "Converts from full_name to FullName" {
        ConvertTo-CamelCase "full_name" | Should -Be "FullName"
    }
}