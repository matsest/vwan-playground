param location string = resourceGroup().location
param policyName string

@allowed([
  'Off'
  'Alert'
  'Deny'
])
param threatIntelMode string = 'Deny'
param dnsServers array = []
param enableProxy bool = true
param tags object = {}

resource policy 'Microsoft.Network/firewallPolicies@2021-03-01' = {
  name: policyName
  location: location
  properties: {
    threatIntelMode: threatIntelMode
    dnsSettings: {
      servers: dnsServers
      enableProxy: enableProxy
    }
  }
  tags: tags
}

output policyName string = policy.name
output policyResourceId string = policy.id

// TODO: Allow some traffic as default rule?
// - Allow regional traffic
// - Allow traffic to/from branches to landing zones
// - Deny internet traffic?
