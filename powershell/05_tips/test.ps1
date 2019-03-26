# Install module
Install-Module -Name pester -Scope CurrentUser

# Run tests
.\ConvertTo-Base64.Tests.ps1

# Process results
Invoke-Pester -Script .\ConvertTo-Base64.Tests.ps1
$Results = Invoke-Pester -Script .\ConvertTo-Base64.Tests.ps1 -PassThru
$Results

# Code coverage
$Results = Invoke-Pester -Script .\ConvertTo-Base64.Tests.ps1 -CodeCoverage ..\03_modules\ConvertTo-Base64.ps1 -PassThru
$Results.CodeCoverage