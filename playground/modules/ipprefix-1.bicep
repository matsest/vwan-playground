// 2020-08-01-1
// Public IP Prefix with IPv4 support only

param name string
param tier string {
  default: 'Regional'
  allowed: [
    'Regional'
    'Global'
  ]
}
param prefixLength int {
  default: 31
  allowed: [
    28
    29
    30
    31
  ]
  metadata: {
    description: 'Specifies the size of the Public IP Prefix'
  }
}
param publicIPAddressVersion string {
  default: 'IPv4'
  allowed: [
    'IPv4'
  ]
  metadata: {
    description: 'Specifies the size of the Public IP Prefix'
  }
}
param location string = resourceGroup().location

resource ipPrefix 'Microsoft.Network/publicIPPrefixes@2020-08-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard'
    tier: tier
  }
  properties: {
    prefixLength: prefixLength
    publicIPAddressVersion: publicIPAddressVersion
  }
}