param appInsightsName string
@allowed([
  'web'
  'ios'
  'other'
  'store'
  'java'
  'phone'
])
param kind string = 'web'

@allowed([
  'other'
  'web'
])
param Application_Type string = 'web'

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: resourceGroup().location
  kind: kind
  properties: { 
    Application_Type: Application_Type
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
  tags: {
    
  }
}

output instrumentKey string = appInsights.properties.InstrumentationKey
output insightsName string = appInsights.properties.Name
