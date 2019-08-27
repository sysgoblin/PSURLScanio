---
Module Name: PSUrlScanio
Module Guid: 00ae67df-b1ae-400c-bcb4-dad7feba9db0
Download Help Link: {{ n/a }}
Help Version: {{ 0.0.0.1 }}
Locale: en-US
---

# PSUrlScanio Module
## Description
Powershell module for interacting with the urlscan.io api.

## PSUrlScanio Cmdlets
### [Connect-UrlScanio](Connect-UrlScanio.md)
Create or update the urlscan.io config file which contains the API key used within the PSUrlScanio module.

### [Get-UrlScanioScan](Get-UrlScanioScan.md)
Get urlscan.io scan results for the provided uuid.

### [Search-UrlScanio](Search-UrlScanio.md)
Search urlscan.io using the provided parameters or providing a filter using Elasticsearch Query String syntax
(https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)

### [Start-UrlScanioScan](Start-UrlScanioScan.md)
Start-UrlScanioScan triggers a scan of the specified URL.