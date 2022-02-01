. $PSScriptRoot\ConvertTo-CamelCasedPSObject.ps1
. $PSScriptRoot\ConvertTo-CamelCase.ps1


function Get-GitHubSummary { 
    param (
        $Repo,
        $Token
    )

    $issues = Get-Issues -Repo $Repo -Token $Token
    $prs = Get-Prs -Repo $Repo -Token $Token
    $notifications = Get-Notifications -Repo $Repo -Token $Token | Where-Object { $_.Unread }

    Get-Summary -Repo $Repo -IssueCount $issues.TotalCount -PrCount $prs.TotalCount -NotificationCount $notifications.Count
}

function Get-Summary {
    param (
        $Repo,
        $IssueCount,
        $PrCount,
        $NotificationCount
    )

    "$Repo $IssueCount $PrCount !$NotificationCount"
}

# Get-Prs is in it's own file as it should
. $PSScriptRoot\Get-Prs.ps1


function Get-Issues {
    param (
        $Repo,
        $Token
    )

    $uri = "https://api.github.com/search/issues?q=repo:$Repo%20is:issue%20is:open"
    Invoke-RestMethod -Method GET -Authentication Bearer -Token $Token -Uri $uri |
        ConvertTo-CamelCasedPSObject
}

function Get-Notifications {
    param (
        $Repo,
        $Token
    )

    $uri = "https://api.github.com/repos/$Repo/notifications"
    Invoke-RestMethod -Method GET -Authentication Bearer -Token $Token -Uri $uri |
        ConvertTo-CamelCasedPSObject
}

Export-ModuleMember -Function 'Get-GitHubSummary'