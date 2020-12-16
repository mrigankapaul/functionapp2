# check the Azure CLI is installed
az

# how to get help for a subgroup 
az functionapp -h

# how to log in
az login

# how to select a subscription
az account set -s "My Subscription Name"

# create a resource group
$resourceGroup = "pluralsightfuncs"
$location = "canadacentral"
az group create -n $resourceGroup -l $location

# create a storage account
$storageAccount = "pluralsightfuncs2019mp"
az storage account create `
  -n $storageAccount `
  -l $location `
  -g $resourceGroup `
  --sku Standard_LRS

# create an app insights instance
echo '{"Application_Type":"web"}' > props.json
$appInsights = "pluralsightfuncs2019"
az resource create `
    -g $resourceGroup -n $appInsights `
    --resource-type "Microsoft.Insights/components" `
    --properties "@props.json"

# create the function app
$functionAppName = "pluralsightfuncs2019mp"
az functionapp create `
    -n $functionAppName `
    -g $resourceGroup `
    --storage-account $storageAccount `
    --app-insights $appInsights `
    --consumption-plan-location $location `
    --runtime dotnet

# how to set app settings
az functionapp config appsettings set `
    -n $functionAppName -g $resourceGroup `
    --settings "SendGridApiKey=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" "EmailSender=paul.mriganka@gmail.com"

