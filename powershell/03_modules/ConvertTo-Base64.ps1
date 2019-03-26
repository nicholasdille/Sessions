function ConvertTo-Base64 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]]$InputObject,

        [validateSet('UTF8', 'ASCII')]
        [string]$Encoding = 'UTF8'
    )

    process {
        foreach ($Line in $InputObject) {
            $ByteArray = [System.Text.Encoding]::$Encoding.GetBytes($Line)
            [Convert]::ToBase64String($ByteArray)
        }
    }
}