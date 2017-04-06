. $PSScriptRoot\Get-Version.ps1

Describe 'Get-Version' {
    It 'Builds the correct version' {
        mock gitVersion.exe {
            '{
                "PreReleaseTag":"beta",
                "MajorMinorPatch":"0.1.0",
                "BranchName":"beta",
                "Sha":"ca146ab02b483ad5f9ac079e64b69575",
                "CommitDate":"2017-04-06"
            }'
        }

        mock Get-Date {
            New-Object -TypeName datetime (2017,02,13,15,30,25)
        }

        $expected = '0.1.0-beta.20170213153025+ca146ab'

        Get-Version | Should Be $expected
    }
}
