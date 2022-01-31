# translate names from full_name syntax to FullName
function ConvertTo-CamelCasedPSObject { 
    param (
        [Parameter(ValueFromPipeline)]
        $Object
    )
 
    process {
        foreach ($o in $Object) {
            $result = @{}
            foreach ($property in $o.PSObject.Properties) {
                $null = $result.Add((ConvertTo-CamelCase $property.Name), $property.Value)
            }
            [PSCustomObject] $result
        }
    }
}