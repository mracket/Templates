param storageAccountName string = 'bicepappstorage'
param applicationInsightsName string = 'BicepAppInsights'
param appServicePlanName string = 'BicepAppServicePlan'
param functionAppName string = 'CloudninjaBicepFunctionApp'

module storageAccount '../Modules/StorageAccount.bicep' = {
  name: storageAccountName
   params: {
     name: storageAccountName
     kind: 'StorageV2'
     skuName: 'Standard_LRS'
   }
}

module applicationInsights '../Modules/ApplicationInsights.bicep' = {
  name: applicationInsightsName 
  params: {
    appInsightsName: applicationInsightsName
    Application_Type: 'web'
    kind: 'web'
  }
  dependsOn: [
    storageAccount
  ]
}

module appServicePlan '../Modules/ApplicationServicePlan.bicep' = {
  name: appServicePlanName
  params: {
    appServicePlanName: appServicePlanName
    skuName: 'Y1'
    skuTier: 'Dynamic'
  }
  dependsOn: [
    applicationInsights
  ]
}

module functionApp '../Modules/FunctionApp.bicep' = {
  name: functionAppName
  params: {
    applicationInsightsKey: applicationInsights.outputs.instrumentKey
    functionAppName: functionAppName
    appServerPlanId: appServicePlan.outputs.id
    storageAccountName: storageAccountName
  }
  dependsOn: [
    storageAccount
    applicationInsights
    appServicePlan
  ]
}
