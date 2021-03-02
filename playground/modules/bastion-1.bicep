// 2020-08-01-1

param name string
param subnetRef string
param publicIpID string
param location string = resourceGroup().location

resource bastion 'Microsoft.Network/bastionHosts@2020-08-01' = {
  name: name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IPConf'
        properties: {
          subnet: {
            id: subnetRef
          }
          publicIPAddress: {
            id: publicIpID
          }
        }
      }
    ]
  }
}

output resourceId string = bastion.id