function Get-ShortHash {
    param($Hash)

    -join $Hash[0..6]
}