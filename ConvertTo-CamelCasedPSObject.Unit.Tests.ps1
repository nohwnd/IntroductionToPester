BeforeAll { 
    Import-Module $PSScriptRoot\GitHubSummary.psm1 -Force -PassThru
    ${function:ConvertTo-CamelCasedPSObject} = InModuleScope -ModuleName GitHubSummary { Get-Command ConvertTo-CamelCasedPSObject }
}

Describe 'ConvertTo-CamelCasedPSObject' {
    It 'Converts from { name = "nohwnd"; full_name = "Jakub Jares" } 
                 to { Name = "nohwnd"; FullName = "Jakub Jares" }' {
        $obj = [PSCustomObject]@{
            name = "nohwnd"
            full_name = "Jakub Jares"
        }

        $actual = ConvertTo-CamelCasedPSObject $obj

        $properties = $actual.PSObject.Properties

        $nameProperty = $properties.Item("Name")
        $nameProperty.Name | Should -BeExactly "Name"
        $nameProperty.Value | Should -BeExactly "nohwnd"

        $fullNameProperty = $properties.Item("FullName")
        $fullNameProperty.Name | Should -BeExactly "FullName"
        $fullNameProperty.Value | Should -BeExactly "Jakub Jares"
    }
}