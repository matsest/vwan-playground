param vpnConfigName string

@secure()
param tenantId string

@secure()
param clientId string
param location string = resourceGroup().location

var aadAuthenticationParameters = {
  aadTenant: '${environment().authentication.loginEndpoint}${tenantId}/'
  aadAudience: clientId
  aadIssuer: 'https://sts.windows.net/${tenantId}/'
}

resource vpnServerConfigurations 'Microsoft.Network/vpnServerConfigurations@2021-03-01' = {
  name: vpnConfigName
  location: location
  properties: {
    vpnProtocols: [
      'OpenVPN'
    ]
    vpnAuthenticationTypes: [
      'AAD'
    ]
    vpnClientRootCertificates: []
    vpnClientRevokedCertificates: []
    radiusServers: []
    radiusServerRootCertificates: []
    radiusClientRootCertificates: []
    aadAuthenticationParameters: aadAuthenticationParameters
    vpnClientIpsecPolicies: []
  }
}

output resourceId string = vpnServerConfigurations.id
