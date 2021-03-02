// 2020-08-01-1

param existingVnetName string
param newSubnetName string
param addressPrefix string
param nsgId string = ''
param routeTableId string = ''
param delegateToService string = ''
param serviceEndpoints object = []

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-08-01' = {
  name: '${existingVnetName}/${newSubnetName}'
  properties: {
    addressPrefix: addressPrefix
    delegations: empty(delegateToService) ? json('null') : [
      {
        name: 'delegation'
        properties: {
          serviceName: delegateToService
        }
      }
    ]
    networkSecurityGroup: empty(nsgId) ? json('null') : {
      id: nsgId
    }
    serviceEndpoints: empty(routeTableId) ? json('null') : serviceEndpoints
    routeTable: empty(routeTableId) ? json('null') : {
      id: routeTableId
    }
  }
}

output id string = subnet.id