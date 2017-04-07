. $PSScriptRoot\Get-Version

function Build-DockerImage ($Tag, $Path) {
    docker build -t $Tag .
}

function New-DockerImage ($Name, $Path) {
    $version = Get-Version # we did not pass the path -- downside of using mocks!
    $tag = $Name + ":" + $version

    Build-DockerImage -Tag $tag -Path $Path
}