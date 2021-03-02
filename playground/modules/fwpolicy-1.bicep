// 2020-08-01
// Support for standard SKU only


param name string
param basePolicyId string
param dnsservers array {
  default: [
    '168.63.129.16'
  ] 
}
param threatIntelWhitelist object
param location string = resourceGroup().location

resource fwPolicy 'Microsoft.Network/firewallPolicies@2020-08-01' = {
  name: name
  location: location
  properties: {
      basePolicy:  empty(basePolicyId) ? json('null') : {
        id: basePolicyId
      }
      threatIntelMode: 'Alert'
      threatIntelWhitelist: {

      }
      dnsSettings: {
          servers: dnsservers
          enableProxy: true
      }
  }
}

output policyName string = fwPolicy.name
output id string = fwPolicy.id