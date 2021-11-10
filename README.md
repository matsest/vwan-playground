# Azure Virtual WAN Playground

Welcome to the Azure Virtual WAN Playground repository! Your one-stop shop for an awesome Azure Virtual WAN lab environment.

## What is Azure Virtual WAN Playground?

This repo is dedicated for all poor souls out there who wants to play around with Azure Virtual WAN but don't have unlimited Azure Credit in their subscriptions. I've put together a template that deploys Azure Virtual WAN and all resources needed to play around with the service and test everything from Site-to-Site VPN, Routing, Secured Virtual Hub, Point-to-Site, Virtual Network connections and more. The goal is to make it easy and fast to spin up an environment when you need to test a feature for a short period of time and then remove it all when finished.

## How it's built

The Azure Virtual WAN Playground is built using [💪Bicep](https://github.com/Azure/bicep). It consists of multiple module templates, some [config files](./playground/configs/README.md) and a main template that puts everything together.

## Deployment

The template is built using the target scope `subscription`. Create a new subscription deployment using your favorite Azure command line tool and sit back and relax.

### Pre-reqs

#### Config

Before you deploy the template, make sure that you add values to the `p2sVpnAADAuth.json` for a successful Point-to-Site VPN deployment. More info about the config files can be found [here](./playground/configs/README.md).

#### Bicep

The Playground is built and tested using [Bicep v0.4.1008](https://github.com/Azure/bicep/releases/tag/v0.4.1008), make sure that you have this or a newer version installed before starting the deployment (or build the Bicep file).

Check installed Bicep version using Bicep CLI (will be used by Azure PowerShell module):
```azurecli
bicep --version
```

Check installed version of Bicep CLI used by Azure CLI:
```azurecli
az bicep version
```

### Create the deployment

Create the deployment using your preferred command line tool.

```powershell
New-AzSubscriptionDeployment -Name vwan-playground -Location westeurope -TemplateFile .\playground\main.bicep
```

```azurecli
az deployment sub create --name vwan-playground --location westeurope --template-file .\playground\main.bicep
```

Enter the required parameter values to begin the deploy.

You can also use the attached deploy script ([PowerShell](./playground/deploy.ps1)) to run these commands.

> :stopwatch: **NOTE**: The deployment is complex and consist of multiple resources that takes a long time to provision. Expected initial deployment time is over 1 hour.

> :money_with_wings: **NOTE**: This deployment is *not* free and will increase your Azure cost. The monthly cost will be approximately 4,000 USD (no guarantees given!) given the default configuration.
>
> See the section below for a guide on how to delete all deployed resources.

### Delete the deployment

To delete all resources, see the description [here](./cleanup/README.md).

## Topology <<**Needs an update**>>

The Azure Virtual WAN Playground deploys the following topology:

> TODO: Describe routing scenario:
>
> - Branch-to-branch: (default)
> - VNET to VNET
> - propagation across hubs

## Test cases / functionality

> TODO: Describe how the playground can be used?
>
> - X-Y traffic
> - Internet break out
> - Filter X-Z traffic
> - Site-to-X traffic
> - Bastion

## Contributing

If you find this project interesting and want to contribute, please feel free to submit Pull Requests with suggested improvements.
