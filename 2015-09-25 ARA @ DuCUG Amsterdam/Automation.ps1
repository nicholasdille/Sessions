# Download credentials
Get-AzurePublishSettingsFile

# Import credentials
Import-AzurePublishSettingsFile -PublishSettingsFile D:\Dokumente\MVP-9-23-2015-credentials.publishsettings

# Create ARA collection (note: single cmdlet for both types)
$Params = @{
    CollectionName = 'cloudsaas'
    ImageName      = 'Office 365 ProPlus (Subscription required)'
    Plan           = 'Basic'
    Location       = 'West Europe'
}
$TrackingId = New-AzureRemoteAppCollection @Params
Get-AzureRemoteAppOperationResult -TrackingId $TrackingId

# Get and filter ARA collections
Get-AzureRemoteAppCollection | Select-Object -Property Name,PlanName,Region,Type,Status | Format-Table -AutoSize

# List ARA cmdlets
Get-Command Get-AzureRemoteApp*

# Available plans
Get-AzureRemoteAppPlan | Select-Object -Property Name,CoresPerUser,MinimumBilledUserCount

# List RemoteApps
Get-AzureRemoteAppProgram -CollectionName saashybrid | Select-Object -Property Name,Status

# Session management
Get-Command *-AzureRemoteAppSession