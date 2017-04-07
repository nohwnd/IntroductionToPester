Describe 'GitVersion' {
    It "Bumps the version based on tag" { 
        pushd TestDrive:\

        git init
        "hello" > hello.txt
        git add .
        git commit -m'first commit'

        (gitVersion | ConvertFrom-Json).MajorMinorPatch | 
            Should Be '0.1.0' 

        git tag '7.1.0'
        (gitVersion | ConvertFrom-Json).MajorMinorPatch | 
            Should Be '7.1.0'
        
        popd
    }
}