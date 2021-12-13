param name string
@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'Storage'
  'StorageV2'
])
param kind string = 'StorageV2'
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param skuName string = 'Standard_LRS'


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: name
  location: resourceGroup().location
  kind: kind
  sku: {
    name: skuName
  }
}
