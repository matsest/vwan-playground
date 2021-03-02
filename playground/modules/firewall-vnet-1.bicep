param name string
param zones array = [
  '1'
  '2'
  '3'
]
param tier string {
  default: 'Premium'
  allowed: [
    'Standard'
    'Premium'
  ]
}
param fwpolicyId string
param subnetId string
param publicIpId array  
param location string = resourceGroup().location

//Update with copy loop based on parameter publicIpId
var ipConfigurations = [
  {
    name: '${name}-IPConf-1'
    properties: {
      subnet: {
        id: subnetId
      }
      publicIPAddress: {
        id: publicIpId[0]
      }
    }
  }
]

resource firewall 'Microsoft.Network/azureFirewalls@2020-08-01' = {
  name: name
  location: location
  zones: zones
  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: tier
    }
    ipConfigurations: ipConfigurations
    firewallPolicy: {
      id: fwpolicyId
    }
  }
}