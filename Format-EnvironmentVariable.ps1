function Format-EnvironmentVariable {
    param ($Name)

    ($Name -creplace "[A-Z]", '_$0'). 
    TrimStart('_').
    ToUpper()

    
}