BeforeAll { 
    Import-Module $PSScriptRoot\GitHubSummary.psm1 -Force
}

Describe 'Get-GitHubSummary' {
    BeforeAll {
        $repo = 'pester/Pester'

        # should return something like this: 
        # pester/Pester 135 13 !2
        $summary = Get-GitHubSummary -Repo $repo -Token $GH
        $summaryParts = $summary -split ' '
    }

    It 'Shows the name of the repo' {
        $name = $summaryParts[0]

        $name | Should -Be $repo
    }

    It 'Shows the number of issues' {
        $issues = $summaryParts[1]

        [int] $issues | Should -BeGreaterThan 0
    }

    It 'Shows the number of PRs' {
        $prs = $summaryParts[2]

        [int] $prs | Should -BeGreaterThan 0
    }

    It 'Shows the number of notifications' {
        $notifications = $summaryParts[3]

        $notifications | Should -BeLike '!*'
        $notifications -replace '!' | Should -BeGreaterThan 0
    }
}