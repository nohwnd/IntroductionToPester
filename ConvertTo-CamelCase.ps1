function ConvertTo-CamelCase ($Value) {
    # full_name -> FullName
    $translated = $(foreach ($part in ($Value -split "_")) { 
        "$($part[0])".ToUpper() + ($part[1..$part.Length] -join '')
    }) -join ''

    $translated
}