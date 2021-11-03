param gwName string
@description('1 scaleunits corresponds to 2 Gbps')
param scaleUnits int = 1
param virtualHubId string
param tags object = {}
param location string = resourceGroup().location

resource expressRouteGw 'Microsoft.Network/expressRouteGateways@2021-03-01' = {
  name: gwName
  location: location
  tags: tags
  properties: {
    virtualHub: {
      id: virtualHubId
    }
    autoScaleConfiguration: {
      bounds: {
        min: scaleUnits
        max: scaleUnits
      }
    }
  }
}

output resourceId string = expressRouteGw.id
output resourceName string = expressRouteGw.name
