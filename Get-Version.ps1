. $PSScriptRoot\hash.ps1

function Get-Version {
    # 0.1.0-beta.20170213153025+ca146ab
    $version = gitVersion.exe | ConvertFrom-Json
    $shortHash = Get-ShortHash $version.Sha
    $date = (Get-Date).ToString("yyyyMMddHHmmss")

    $version.MajorMinorPatch + "-" + $version.PreReleaseTag `
    + "." + $date + "+" + $shortHash
}