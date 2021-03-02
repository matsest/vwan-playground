// 2020-08-01-1

param vnetName string
param peeringName string
param allowForwardedTraffic bool
param allowGatewayTransit bool
param useRemoteGateways bool
param allowVirtualNetworkAccess bool = true
param remoteVnetId string

resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = {
  name: any('${vnetName}/${peeringName}')
  properties: {
    allowVirtualNetworkAccess: allowVirtualNetworkAccess
    allowForwardedTraffic: allowForwardedTraffic
    allowGatewayTransit: allowGatewayTransit
    useRemoteGateways: useRemoteGateways
    remoteVirtualNetwork: {
      id: remoteVnetId
    }
  }
}

output id string = peering.id