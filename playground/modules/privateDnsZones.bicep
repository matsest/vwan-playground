param namePrefix string
param tags object = {}

var name = '${namePrefix}.com'

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: name
  location: 'global'
  tags: tags
}

output resourceId string = privateDnsZone.id
output resourceName string = privateDnsZone.name
