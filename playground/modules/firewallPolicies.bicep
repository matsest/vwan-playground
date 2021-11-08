param location string = resourceGroup().location
param parentPolicyName string
param childPolicyName string

@allowed([
  'Off'
  'Alert'
  'Deny'
])
param threatIntelMode string = 'Deny'
param dnsServers array = []
param enableProxy bool = true

// does it not make sense to have one parent policy for the vwan (all regions) and have one child per region (fw)?
resource parentPolicy 'Microsoft.Network/firewallPolicies@2021-03-01' = {
  name: parentPolicyName
  location: location
  properties: {
    threatIntelMode: threatIntelMode
  }
}

resource childPolicy 'Microsoft.Network/firewallPolicies@2021-03-01' = {
  name: childPolicyName
  location: location
  properties: {
    basePolicy:{
      id: parentPolicy.id
    }
    threatIntelMode: threatIntelMode
    dnsSettings: {
      servers: dnsServers
      enableProxy: enableProxy
    }
  }
}

output parentName string = parentPolicy.name
output parentResourceId string = parentPolicy.id
output childName string = childPolicy.name
output childResourceId string = childPolicy.id
