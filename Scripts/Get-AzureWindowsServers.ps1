Write-Host "Microsoft VM Image Publishers:"
Get-AzureRmVMImagePublisher -Location eastus | Where-Object { $_.PublisherName -like "*icrosoft*" }

Write-Host "Microsoft Windows-Hub VM Image SKUs"
Get-AzureRmVMImageSku -Location eastus -PublisherName MicrosoftWindowsServer -Offer Windows-Hub

Write-Host "Microsoft Windows Server VM Image SKUs"
get-azurermvmimagesku -Location eastus -PublisherName MicrosoftWindowsServer -Offer WindowsServer

Write-Host "Microsoft Windows Client VM Image SKUs" 
get-azurermvmimagesku -Location eastus -PublisherName MicrosoftVisualStudio -Offer Windows