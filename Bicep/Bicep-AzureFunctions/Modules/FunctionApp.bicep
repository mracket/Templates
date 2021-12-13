param functionAppName string 
param appServerPlanId string 
param applicationInsightsKey string 
param storageAccountName string


resource storageAccountLookup 'Microsoft.Storage/storageAccounts@2021-06-01' existing = {
  name: storageAccountName
}

resource functionApp 'Microsoft.Web/sites@2021-02-01' = {
  name: functionAppName
  location: resourceGroup().location
  kind: 'functionapp'
  properties: {
    httpsOnly: true
    serverFarmId: appServerPlanId
    clientAffinityEnabled: true
    siteConfig: {
      appSettings: [
        {
          'name': 'APPINSIGHTS_INSTRUMENTATIONKEY'
          'value': applicationInsightsKey
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountLookup.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccountLookup.id, storageAccountLookup.apiVersion).keys[0].value}'
        }
        {
          'name': 'FUNCTIONS_EXTENSION_VERSION'
          'value': '~3'
        }
        {
          'name': 'FUNCTIONS_WORKER_RUNTIME'
          'value': 'powershell'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountLookup.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccountLookup.id, storageAccountLookup.apiVersion).keys[0].value}'
        }
      ]
    }
  }
  dependsOn: [   
  ]
}
