targetScope = 'subscription'

/////////////////////////////////////////////////////////
// Shared parameters
/////////////////////////////////////////////////////////
var tags = {
  'Environment': 'Demo'
  'Owner': 'Martin'
}

/////////////////////////////////////////////////////////
// Resource group parameters
/////////////////////////////////////////////////////////
param resourceGroupName string = 'rg-nsg-demo-001'

/////////////////////////////////////////////////////////
// Route table parameters
/////////////////////////////////////////////////////////
var routeTables = [
  {
    name: 'rt-avd-routes'
    routes: [
      {
        name: 'udr-forcedtunneling-001'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualNetworkGateway'
        }
      }
      {
        name: 'udr-cloudninjawebiste-001'
        properties: {
          addressPrefix: '185.20.205.57/32'
          nextHopType: 'Internet'
        }
      }
    ]
  }
  {
    name: 'rt-domainservices-routes'
    routes: [
      {
        name: 'udr-forcedtunneling-001'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualNetworkGateway'
        }
      }      
    ]
  }    
]

/////////////////////////////////////////////////////////
// Network security group parameters
/////////////////////////////////////////////////////////
var NetworkSecurityGroups = [
  {
    name: 'nsg-snet-adds-001'
    rules: [
      {
      name: 'rule-deny-all'
      properties: {
        description: 'description'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '*'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
        access: 'Deny'
        priority: 3000
        direction: 'Inbound'
        }      
      }
      {
      name: 'rule-allow-rdp'
      properties: {
        description: 'description'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '3389'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
        access: 'Allow'
        priority: 400
        direction: 'Inbound'
        } 
      }      
    ]
  }
  {
    name: 'nsg-snet-adconnect-001'
    rules: [
      {
      name: 'rule-deny-all'
      properties: {
        description: 'description'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '*'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
        access: 'Deny'
        priority: 3000
        direction: 'Inbound'
        }      
      }
      {
      name: 'rule-allow-rdp'
      properties: {
        description: 'description'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '3389'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
        access: 'Allow'
        priority: 400
        direction: 'Inbound'
        } 
      }
    ]    
  }
  {
    name: 'nsg-snet-iis-001'
    rules: [
      {
      name: 'rule-deny-all'
      properties: {
        description: 'description'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '*'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
        access: 'Deny'
        priority: 3000
        direction: 'Inbound'
        }      
      }
      {
      name: 'rule-allow-https'
      properties: {
        description: 'description'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '443'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
        access: 'Allow'
        priority: 300
        direction: 'Inbound'
        } 
      }
    ]    
  }    
]
/////////////////////////////////////////////////////////
// Deployment start
/////////////////////////////////////////////////////////
module nsg '../Modules/NetworkSecurityGroup.bicep' =  {
  name: 'NSGDeployment'
  scope: resourceGroup(resourceGroupName)
  params: {
    networkSecurityGroups: NetworkSecurityGroups 
    tags: tags   
  }
  dependsOn: [
    
  ]
}

module routes '../Modules/Route.bicep' =  {
  name: 'routes'
  scope: resourceGroup(resourceGroupName)
  params: {
    routeTables: routeTables  
    tags: tags  
  }
  dependsOn: [
    
  ]
}

