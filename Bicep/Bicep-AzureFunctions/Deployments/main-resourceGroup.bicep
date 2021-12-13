targetScope = 'subscription'
param resourceGroupName string = 'BicepDemo'
param location string = 'WestEurope'

resource ResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName 
  location: location  
}
