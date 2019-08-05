function Get-UrlScanioApiKey {
    if (!(Test-Path -Path "$($env:AppData)\psurlscanio\urlscankey.json")) {
        Throw "PSURLScanio Configuration file not found in `"$($env:AppData)\psurlscanio\urlscankey.json`", please run Set-UrlScanConfig to configure api key."
    } else {
        $config = Get-Content "$($env:AppData)\psurlscanio\urlscankey.json"
        $apiKeySecString = $config | ConvertTo-SecureString
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($apiKeySecString)
        $apiKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

        $Script:apiKey = $apiKey
    }
}