function Connect-UrlScanio {
    [CmdletBinding()]
    param (
        [string]$ApiKey
    )

    if (!(Test-Path -Path "$($env:AppData)\psurlscanio\urlscankey.json")) {
        New-Item -Path "$($env:AppData)\psurlscanio\urlscankey.json" -Force
        Write-Verbos "Creating config file at $($env:AppData)\psurlscanio\urlscankey.json"
    }

    $apiKey = ConvertTo-SecureString $ApiKey -AsPlainText -Force | ConvertFrom-SecureString
    $apiKey | Out-File "$($env:AppData)\psurlscanio\urlscankey.json" -Force
    Write-Verbose "Saved key as secure string to config file"
}