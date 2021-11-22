param networkSecurityGroups array 
param tags object

resource NetworkSecurityGroups 'Microsoft.Network/networkSecurityGroups@2021-03-01' = [for networkSecurityGroup in networkSecurityGroups: {
  name: networkSecurityGroup.name
  location: resourceGroup().location
  properties: {
    securityRules: networkSecurityGroup.rules
  }
  tags: tags
}]
