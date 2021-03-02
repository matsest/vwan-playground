// 2020-08-01-1

// Deploy WAF Policy for Application Gateway

param location string = resourceGroup().location
param wafName string
param tags object = {}
param wafMode string {
  default: 'Prevention'
  allowed: [
    'Prevention'
    'Detection'
  ]
}
param wafState string {
  default: 'Enabled'
  allowed: [
    'Enabled'
    'Disabled'
  ]
}
param requestBodyCheck bool = true
param fileUploadLimitInMb int = 100
param maxRequestBodySizeInKb int = 128
param customRules array = []
param ruleSetType string = 'OWASP'
param ruleSetVersion string = '3.1'
param ruleGroupOverrides array = []

resource wafPolicy 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2020-08-01' = {
  name: wafName
  location: location
  tags: tags
  properties: {
    policySettings: {
      mode: wafMode
      state: wafState
      requestBodyCheck: requestBodyCheck
      fileUploadLimitInMb: fileUploadLimitInMb
      maxRequestBodySizeInKb: maxRequestBodySizeInKb
    }
    customRules: customRules
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: ruleSetType
          ruleSetVersion: ruleSetVersion
          ruleGroupOverrides: ruleGroupOverrides
        }
      ]
    }
  }
}

output id string = wafPolicy.id