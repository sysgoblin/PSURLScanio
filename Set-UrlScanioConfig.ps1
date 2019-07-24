function Set-UrlScanioConfig {
    [CmdletBinding()]
    param (
        [string]$ApiKey
    )

    if (!(Test-Path -Path "$($env:AppData)\psurlscanio\urlscankey.json")) {
        New-Item -Path "$($env:AppData)\psurlscanio\urlscankey.json" -Force
    }

    $apiKey = ConvertTo-SecureString $ApiKey -AsPlainText -Force | ConvertFrom-SecureString
    $apiKey | Out-File "$($env:AppData)\psurlscanio\urlscankey.json" -Force
}