param location string = resourceGroup().location
param namePrefix string = 'contoso'
param sku string {
  default: 'Premium'
  allowed: [
    'Standard'
    'Premium'
  ]
}

var basePolicyName = '${namePrefix}-${sku}-base-policy'
var standardPolicyName =  '${namePrefix}-${location}-fw-standard-policy'
var premiumPolicyName =  '${namePrefix}-${location}-fw-premium-policy'
var identityConfig = {
  type: 'UserAssigned'
  userAssignedIdentities: {
    '${identity.id}': {}
  }
}

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'fw-identity'
  location: location
}

//Parent Firewall Policy
resource basePolicy 'Microsoft.Network/firewallPolicies@2020-08-01' = {
  name: basePolicyName
  location: location
  properties: {
    sku: {
      tier: sku
    }
  }
}

//Child Firewall Policy if SKU is Standard
resource standardChildPolicy 'Microsoft.Network/firewallPolicies@2020-08-01' = if (sku == 'Standard') {
  name: standardPolicyName
  location: location
  properties: {
    sku: {
      tier: sku
    }
    basePolicy: {
      id: basePolicy.id
    }
  }
}

//Child Firewall Policy if SKU is Premium
resource premiumChildPolicy 'Microsoft.Network/firewallPolicies@2020-08-01' = if (sku == 'Premium') {
  name: premiumPolicyName
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