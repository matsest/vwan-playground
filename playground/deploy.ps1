$timeStamp = (Get-Date -Format yyMMdd-HHmmss).ToString()

$params = @{
    Name         = "vwan-deploy-$timeStamp"
    Location     = "westeurope"
    TemplateFile = "$PSScriptRoot/main.bicep"
}

Write-Host "Deploying vwan-playground..."
Write-Host "Note: This can take up to 1 hour!"

New-AzSubscriptionDeployment @params -Verbose