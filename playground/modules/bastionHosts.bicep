param name string
param subnetId string
param location string = resourceGroup().location
param tags object = {}

resource bastionip 'Microsoft.Network/publicIPAddresses@2021-03-01' = {
  name: '${name}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  tags: tags
}

resource bastion 'Microsoft.Network/bastionHosts@2021-03-01' = {
  name: name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IPConf'
        properties: {
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: bastionip.id
          }
        }
      }
    ]
  }
  tags: tags
}
