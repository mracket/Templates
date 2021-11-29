////////////////////////////////////////////////////////////////////////////////
// VM parameters
////////////////////////////////////////////////////////////////////////////////
param vmName string = 'vm-demo-001'
param vmSize string = 'Standard_b2s'
param adminUsername string = 'LocalAdmin'
param vNetName string = 'vnet-demo-001' 
param vNetResourceGroup string = 'rg-bicep-demo-001'
param subnetName string = 'snet-demo-001'
var tags = {
  'Environment': 'Demo'
  'Owner': 'Martin'
} 

////////////////////////////////////////////////////////////////////////////////
// Key vault parameters
////////////////////////////////////////////////////////////////////////////////
param subscriptionId string = 'GUID'
param keyVaultResourceGroup string = 'rg-keyvault-001'
param keyVaultName string = 'kv-passwords-001'

resource kv 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: keyVaultName
  scope: resourceGroup(subscriptionId, keyVaultResourceGroup )
}

////////////////////////////////////////////////////////////////////////////////
// Deployment start
////////////////////////////////////////////////////////////////////////////////
module virtualMachine 'Modules/VirtualMachine.bicep' =  {
  name: vmName
  params: {
    adminUsername: adminUsername
    subnetName: subnetName
    VMName: vmName
    VMSize: vmSize
    adminPassword: kv.getSecret('vm-local-admin')
    vNetName: vNetName
    vNetResourceGroup: vNetResourceGroup
    tags: tags

  }
  dependsOn: [    
  ]  
}
