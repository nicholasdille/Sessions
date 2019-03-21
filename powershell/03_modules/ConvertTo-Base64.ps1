function ConvertTo-Base64 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]]$InputObject,

        [validateSet('UTF8', 'ASCII')]
        [string]$Encoding = 'UTF8'
    )

    foreach ($Line in $InputObject) {
        $ByteArray = [System.Text.Encoding]::$Encoding.GetBytes($Item)
        [Convert]::ToBase64String($ByteArray)
    }
}