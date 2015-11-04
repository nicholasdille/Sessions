workflow Get-Parallel {
    [CmdletBinding()]
    [OutputType([array])]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $ComputerName
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [scriptblock]
        $ScriptBlock
    )

    $Results = @()
    foreach -parallel ($Target in $ComputerName) {
        Parallel {
            $workflow:Results += InlineScript {
                $([scriptblock]::Create($Using:ScriptBlock)).Invoke()
            } -PSComputerName $Target
        }
    }

    $Results
}

#region Konfigurierte Controller von Worker auslesen
Get-Parallel -ComputerName vda-01,vda-02 -ScriptBlock {Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Citrix\VirtualDesktopAgent -Name ListOfDDCs | Select-Object -ExpandProperty ListOfDDCs}
#endregion Konfigurierte Controller von Worker auslesen

#region Upline aller Worker auslesen
Get-Parallel -ComputerName vda-01,vda-02 -ScriptBlock {
    $BootTime = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty LastBootUpTime
    (Get-Date).Subtract($BootTime).TotalSeconds
} | Measure-Object -Sum | Select-Object -ExpandProperty Sum
#endregion Upline aller Worker auslesen