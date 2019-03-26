# Comment based help
    <#
    .SYNOPSIS
    Converts a string to Base64

    .DESCRIPTION
    The input provided as parameter or on the pipeline is converted line-by-line to Base64

    .PARAMETER InputObject
    Array of input strings

    .PARAMETER Encoding
    Encoding to use when converting to Base64. Valid values are UTF8 and ASCII. Default is UTF8.

    .EXAMPLE
    ConvertTo-Base64 'blarg', 'blubb'

    .EXAMPLE
    'fubar', 'snafu' | ConvertTo-Base64

    .EXAMPLE
    'lgtm' | ConvertTo-Base64 -Encoding ASCII
    #>
ConvertTo-Base64 -?
Get-Help ConvertTo-Base64 -Full

# Copy example module
Copy-Item -Path "..\03_modules\Base64\" -Destination . -Recurse

# Install platyPS
Install-Module -Name platyPS -Scope CurrentUser
Get-Command -Module platyPS

# Add markdown help
New-Item -Path ".\Base64\docs" -ItemType Directory -Force
New-MarkdownHelp -Command ConvertTo-Base64 -OutputFolder .\Base64\docs\
# edit .\Base64\docs\ConvertTo-Base64.md

# Compile help
New-ExternalHelp -Path .\Base64\docs\ -OutputPath .\Base64\en-US\