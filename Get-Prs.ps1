function Get-Prs {
    param (
        $Repo,
        $Token
    )

    $uri = "https://api.github.com/search/issues?q=repo:$Repo%20is:pr%20is:open"
    Invoke-RestMethod -Method GET -Authentication Bearer -Token $Token -Uri $uri |
        ConvertTo-CamelCasedPSObject 
}