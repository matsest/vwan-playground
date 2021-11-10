param name string
@allowed([
  'Basic'
  'Standard'
])
param sku string = 'Standard'
param addressPrefix string
param virtualRouterAsn int = 0
param virtualRouterIps array = []
param virtualWanId string
param allowBranchToBranchTraffic bool = true
param tags object = {}
param location string = resourceGroup().location

resource hub 'Microsoft.Network/virtualHubs@2021-03-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    virtualWan: {
      id: virtualWanId
    }
    addressPrefix: addressPrefix
    sku: sku
    virtualRouterAsn: virtualRouterAsn == 0 ? json('null') : virtualRouterAsn
    virtualRouterIps: virtualRouterIps == [] ? json('null') : virtualRouterIps
    allowBranchToBranchTraffic: allowBranchToBranchTraffic
  }
}

output resourceId string = hub.id
output resourceName string = hub.name
output virtualRouterIps array = hub.properties.virtualRouterIps
output virtualRouterAsn int = hub.properties.virtualRouterAsn
