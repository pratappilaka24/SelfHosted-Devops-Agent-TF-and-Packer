param(
    [String] [Parameter (Mandatory=$true)] $ClientId,
    [String] [Parameter (Mandatory=$true)] $ClientSecret,
    [String] [Parameter (Mandatory=$true)] $TenantId,
    [String] [Parameter (Mandatory=$true)] $SubscriptionId,
    [String] [Parameter (Mandatory=$true)] $ResourceGroup,
    [String] [Parameter (Mandatory=$true)] $VmssNames,
    [String] [Parameter (Mandatory=$true)] $ManagedImageId
)

az login --service-principal --username $ClientId --password $ClientSecret --tenant $TenantId | Out-Null
az account set -s $SubscriptionId

$VmssNames.Split(",") | ForEach {
  $VmssName = $_
  az vmss create --resource-group $ResourceGroup --name $VmssName --image $ManagedImageId --admin-username "labadmin" --admin-password "Newzealand1!" --instance-count 1 
  Write-Host "Created Virtual Machine Scale Set ManagedImageId: $VmssName - $ManagedImageId"
}
