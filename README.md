[![Build Status](https://dev.azure.com/cbaylissmk2/github%20projects/_apis/build/status/sysgoblin.PSURLScanio?branchName=dev)](https://dev.azure.com/cbaylissmk2/github%20projects/_build/latest?definitionId=2&branchName=dev)
[![Powershell Gallery](https://img.shields.io/badge/PSGallery-0.5-yellow)](https://www.powershellgallery.com/packages/PSUrlScanio/0.5)

# PSURLScanio 🔍
> A Powershell module for using the urlscan.io API.

PSURLScanio/PSUrlScanio is a Powershell module/wrapper for the urlscan.io API. The module allows you to quickly query/submit data to the service and incorporate it in to your automated threat hunting/intel processes using PoSh.

For example, let's hunt for some potential HSBC phishing pages that have embedded the companies logo! 🕵️‍
![demo1](https://i.imgur.com/wcCeW1D.gif)

# Install 📦
Head over to urlscan.io and get yourself an API key (https://urlscan.io/user/apikey/new/), install the module and then run Connect-UrlScanio to set your key.
```powershell
Install-Module -Name PSUrlScanio -Repository PSGallery
Connect-UrlScanio -ApiKey "2126abb6-3686-47ef-bae5-9daf6c9e0888"
```

# Examples 📜
### Search for the last scan for the domain github.com.
```powershell
Search-Urlscanio -Domain github.com -Limit 1 -Specific

TaskDate   : 28/08/2019 19:01:45
Submission : api
id         : 3313e096-3f4a-496f-9e9c-b0924e4d6824
URL        : https://github.com/
ApiResult  : https://urlscan.io/api/v1/result/3313e096-3f4a-496f-9e9c-b0924e4d6824
ResultPage : https://urlscan.io/result/3313e096-3f4a-496f-9e9c-b0924e4d6824
```
(Omitting ```-Specific``` will return any scans where github.com is called in any http request while loading the page)

### Do the same but return the entire response rather than basic details.
```powershell
Search-Urlscanio -Domain github.com -Limit 1 -Specific -Raw Object

task           : @{visibility=public; method=api; ...}
stats          : @{uniqIPs=3; consoleMsgs=0; dataLength=746649; ...}
page           : @{country=US; server=GitHub.com; city=; ...}
uniq_countries : 2
_id            : 3313e096-3f4a-496f-9e9c-b0924e4d6824
result         : https://urlscan.io/api/v1/result/3313e096-3f4a-496f-9e9c-b0924e4d6824
```

### Get results from a specific scan id.
```powershell
Get-UrlScanioScan -uuid 03ba7a78-e779-4743-ae37-2b683ee9ec74

data     : @{requests=System.Object[]; cookies=System.Object[]; ...}
stats    : @{resourceStats=System.Object[]; protocolStats=System.Object[]; ...}
meta     : @{processors=}
task     : @{uuid=03ba7a78-e779-4743-ae37-2b683ee9ec74; ...}
page     : @{url=https://www.google.com/?gws_rd=ssl; domain=www.google.com; ...}
lists    : @{ips=System.Object[]; countries=System.Object[]; ...}
verdicts : @{overall=; urlscan=; engines=; community=}
```

### Kick off a scan on the chosen domain/URL and return the scan results.
```powershell
Start-UrlScanioScan -Url google.com -ShowResults

data     : @{requests=System.Object[]; cookies=System.Object[]; ...}
stats    : @{resourceStats=System.Object[]; protocolStats=System.Object[]; tlsStats=System.Object[]; ...}
meta     : @{processors=}
task     : @{uuid=781d9c96-7638-4393-b504-3cbc1ef5adfc; time=28/08/2019 19:58:22; ...}
page     : @{url=http://www.google.com/sorry/index?continue=http://google.com/&q=EhAqAQT4AZJUFAAAAAAAAAACGN65m-sFIhkA8aeDS4ML-09ouMDyyvDlbF81DD9ZWHvMMgFy; ...}
lists    : @{ips=System.Object[]; countries=System.Object[]; asns=System.Object[]; domains=System.Object[]; servers=System.Object[]; urls=System.Object[]; linkDomains=System.Object[]; certificates=System.Object[]; hashes=System.Object[]}
verdicts : @{overall=; urlscan=; engines=; community=}
```
(Example results have been truncated)

# FAQ ❓

 - **Can I contribute?**
   - Yes please! Feel free to clone/test/add features and submit a PR or enhancement suggestion. Help yourself to the project board if you feel like it!
 - **Why can I only get 10000 results? There are way more for this domain!**
   - 10k results is the max limit for the API, and I haven't figured out a magical way around it (yet...).
 - **Something's broke.**
   - Please submit an issue for it and I'll take a look!

# Support

Feel free to reach out to me via twitter <a href="https://twitter.com/sysgoblin" target="_blank">`@sysgoblin`</a>.

If you fancy supporting me and what I'm working on you can always buy me a sfw beer (aka coffee) by the sponsor button on this repo. ☕👌