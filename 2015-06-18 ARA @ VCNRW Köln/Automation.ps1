# Import credentials
Import-AzurePublishSettingsFile -PublishSettingsFile "$Env:UserProfile\Documents\TEMP\MVP-6-17-2015-credentials.publishsettings"

# Get and filter ARA collections
Get-AzureRemoteAppCollection | select Name,Plan,Region,Type,Status | Format-Table -AutoSize

# List ARA cmdlets
Get-Command Get-AzureRemoteApp*

# Available plans
Get-AzureRemoteAppPlan | select Name,CoresPerUser,MinimumBilledUserCount

# List RemoteApps
Get-AzureRemoteAppProgram -CollectionName saashybrid | select Name,Status

# Session management
Get-Command *-AzureRemoteAppSession