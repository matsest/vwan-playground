#This script removes all components of the Virtual WAN Playground
param(
  $subscriptionID = '',
  $rgNames = @("contoso-vwan-rg", "contoso-mgmt-rg", "contoso-spoke1-rg", "contoso-onprem-rg"),
  ## Number and names of RG's will depend on config.
  ## Can we parse config file or do a tag-based lookup for simpler lookup? (or add explicit cleanup steps)
  $cleanuptemplate = "$PSScriptRoot/cleanup.json"
)

#Select subscription
Select-AzSubscription -SubscriptionId $subscriptionID

#Remove all resources by deploying and emtpy template using Complete mode
$jobs = foreach ($rg in $rgNames) {
  New-AzResourceGroupDeployment -Name "cleanup-$rg" -ResourceGroupName $rg -TemplateFile .\cleanup.json -Mode Complete -Force -AsJob
}

#Remove all resource groups
$rgNames | ForEach-Object -Parallel {
  Remove-AzResourceGroup -Name $_ -Force
}