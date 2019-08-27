[![Build Status](https://dev.azure.com/cbaylissmk2/github%20projects/_apis/build/status/sysgoblin.PSURLScanio?branchName=dev)](https://dev.azure.com/cbaylissmk2/github%20projects/_build/latest?definitionId=2&branchName=dev)
[![Powershell Gallery](https://img.shields.io/badge/PSGallery-0.1.0-yellow)](https://www.powershellgallery.com/packages/PSUrlScanio/0.1.5)


# PSURLScanio (road to v1.0!)
Powershell module for interacting with the urlscan.io API.

## Setting up
Head over to urlscan.io and get yourself an API key (https://urlscan.io/user/apikey/new/), install the module and then run Connect-UrlScanio.
```powershell
Install-Module -Name PSUrlScanio -Repository PSGallery
```

## Examples
Search for the last 2 scans for the domain github.com
```powershell
Search-Urlscanio -Domain github.com -Limit 2
```
![screen1](https://i.imgur.com/2V8YlFQ.gif)

Do the same but return the entire json response rather than basic details
```powershell
Search-Urlscanio -Domain github.com -Limit 2 -Raw
```
![screen2](https://i.imgur.com/p6wIFSF.gif)


Get results from a specific scan id (atm this just returns parsed raw json)
```powershell
Get-UrlScanioScan -uuid 03ba7a78-e779-4743-ae37-2b683ee9ec74
```

Kick off a scan on the chosen domain/URL (omitting -Raw will result in the report URL being returned)
```powershell
Start-UrlScanioScan -Url google.com -Raw
```
![screen2](https://i.imgur.com/cyVxskb.gif)
