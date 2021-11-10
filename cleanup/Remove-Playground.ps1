# This script removes all components of the Virtual WAN Playground
param(
  [Parameter()]
  [string]
  $subscriptionID,
  [Parameter()]
  [string]
  $cleanuptemplate = "$PSScriptRoot/cleanup.json",
  [Parameter()]
  [hashtable]
  $tags = @{Application = 'vwan-playground' }
)

# Select subscription
Select-AzSubscription -SubscriptionId $subscriptionID

# Get resource groups that matches tags
$rgs = Get-AzResourceGroups -Tag $tags
$rgNames = $rgs | Select-Object -ExpandProperty ResourceGroupName

Write-Host "This will delete resources in the following resource groups:"
Write-Host "`t$($rgNames -join "`n" )"

$confirmation = Read-Host "Are you Sure You Want To Proceed:"
if ($confirmation -ne 'y') {
  Write-Host "Exiting..."
  exit
}
elseif ($confirmation -eq 'y') {
  #Remove all resources by deploying and emtpy template using Complete mode
  Write-Host "Removing all resources in selected resource groups..."
  foreach ($rg in $rgNames) {
    New-AzResourceGroupDeployment -Name "cleanup-$rg" -ResourceGroupName $rg -TemplateFile .\cleanup.json -Mode Complete -Force -AsJob
  }

  Write-Host "Removing selected resource groups..."
  #Remove all resource groups
  $rgNames | ForEach-Object -Parallel {
    Remove-AzResourceGroup -Name $_ -Force
  }
}