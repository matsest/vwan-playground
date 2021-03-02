param location string = resourceGroup().location
param namePrefix string = 'fabrikam'
param sku string {
  default: 'Standard'
  allowed: [
    'Standard'
    'Premium'
  ]
}

var basePolicyName = toLower('${namePrefix}-organizational-${sku}-base-policy')
var childPolicyName =  toLower('${namePrefix}-${location}-${sku}-fw-policy')
var identityConfig = {
  type: 'UserAssigned'
  userAssignedIdentities: {
    '${identity.id}': {}
  }
}

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = if (sku == 'Premium') {
  name: 'fw-identity'
  location: location
}

//Parent Firewall Policy
resource basePolicy 'Microsoft.Network/firewallPolicies@2020-07-01' = {
  name: basePolicyName
  location: location
  properties: {
    sku: {
      tier: sku
    }
  }
}

resource childPolicy 'Microsoft.Network/firewallPolicies@2020-07-01' = {
  name: childPolicyName
  location: location
  properties: {
    sku: {
      tier: sku
    }
    basePolicy: {
      id: basePolicy.id
    }
  }
  identity: sku == 'Premium' ? identityConfig : json('null')
}