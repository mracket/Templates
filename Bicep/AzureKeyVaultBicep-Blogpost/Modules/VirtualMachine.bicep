param VMName string 
param vNetName string 
param adminUsername string
@secure() 
param adminPassword string 
param subnetName string 
param VMSize string
param vNetResourceGroup string 
param tags object 

resource NIC 'Microsoft.Network/networkInterfaces@2021-03-01' = {
  name: '${VMName}-nic-1'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {            
            id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${vNetResourceGroup}/providers/Microsoft.Network/virtualNetworks/${vNetName}/subnets/${subnetName}'            
          }
          privateIPAllocationMethod: 'Dynamic'       
        }     
      }      
    ]
  }
  tags: tags  
}
 
resource VirtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = { 
  name: VMName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: VMSize
    }
        
    osProfile: {
      adminPassword: adminPassword
      adminUsername: adminUsername
      computerName: VMName
      windowsConfiguration: {
        enableAutomaticUpdates: true
        timeZone: 'W. Europe Standard Time'
      }      
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true            
          }
          id: NIC.id
        }
      ]      
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        name: '${VMName}-OSDisk-1'
      }
    }
  }
  tags: tags  
  dependsOn: [
    NIC
  ]
}
