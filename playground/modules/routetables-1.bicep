// 2020-08-01-1

// Deploy Route Table

param name string
param routes array = []
param disableBgpRoutePropagation bool = false
param tags object = {}
param location string = resourceGroup().location

resource routeTable 'Microsoft.Network/routeTables@2020-08-01' = {
  name: name
  location: location
  tags: tags  
  properties: {
    disableBgpRoutePropagation: disableBgpRoutePropagation
    routes: routes == [] ? [] : routes
  }
}

output id string = routeTable.id