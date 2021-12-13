targetScope = 'subscription'
param resourceGroupName string
param location string 

resource ResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName 
  location: location  
}
