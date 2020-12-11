#Set Defaults for future commands
$pnpParams = @{
    URL        = 'https://justingrote.sharepoint.com/'
    #This fetches a stored credential using the new SecretManagement provider. You can also use Get-Credential
    Credential = Get-Secret PnPDev
}

#Connect using the PNP Management Shell App using splatting
Connect-PnPOnline @pnpParams

#List all site collections in the tenant
Get-PnPTenantSite

#Switch to a relevant site
$pnpDemoSiteUrl = Get-PnPTenantSite | Where-Object url -like '*pnpdemo' | Select-Object -ExpandProperty Url
Connect-PnPOnline @pnpParams -url $pnpDemoSiteUrl

#Verify we are in the right place
(Get-PnPContext).url


#Create a Garden subsite
$GardenSiteParams = @{
    Title       = 'GardenPnP'
    Url         = 'GardenPnP'
    Description = 'Garden Subsite PnP'
    Template    = 'STS#0'
}
New-PnPWeb @GardenSiteParams -OutVariable GardenSite

#Switch to our new subsite
Connect-PnPOnline @pnpParams -url $pnpDemoSiteUrl

#Verify we are in the right place
(Get-PnPContext).url