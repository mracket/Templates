param routeTables array
param tags object

resource routeTablename_resource 'Microsoft.Network/routeTables@2020-03-01' = [for routeTable in routeTables: {
  name: routeTable.name
  location: resourceGroup().location
  properties: {
    disableBgpRoutePropagation: true
    routes: routeTable.routes
  }
  tags: tags
}]
