# PSURLScanio
Powershell module for interacting with the urlscan.io API.

## Setting up
Head over to urlscan.io and get yourself an API key (https://urlscan.io/user/apikey/new/), then run Connect-UrlScanio
```powershell
Connect-UrlScanio -ApiKey abcdefg1234567
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