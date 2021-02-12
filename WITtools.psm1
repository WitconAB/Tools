# Implement your your modulefunctions in this script.


# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.


$functions = @( Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 -Recurse -ErrorAction SilentlyContinue )
Foreach($import in @($functions)) {
    . $import.fullname
   
}

