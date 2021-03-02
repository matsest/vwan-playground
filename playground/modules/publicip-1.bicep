// 2020-08-01-1

// Deploy Public IP Address

param location string = resourceGroup().location
param publicIpName string
param sku string {
  default: 'Standard'
  allowed: [
    'Standard'
    'Basic'
  ]
}
param zones array {
  default: []
}
param publicIPAllocationMethod string {
  default: 'Static'
  allowed: [
    'Static'
    'Dynamic'
  ]
}
param publicIPAddressVersion string {
  default: 'IPv4'
  allowed: [
    'IPv4'
    'IPv6'
  ]
}
param domainNameLabel string = publicIpName
param publicIPPrefixId string = ''
param tags object = {}

var ipPrefixProp = {
  id: publicIPPrefixId
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: publicIpName
  location: location
  tags: tags
  zones: zones
  sku: {
    name: sku
  }
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
    publicIPAddressVersion: publicIPAddressVersion
    dnsSettings: {
      domainNameLabel: domainNameLabel
    }
    publicIPPrefix: publicIPPrefixId == '' ? json('null') : ipPrefixProp
  }
}

output id string = publicIp.id