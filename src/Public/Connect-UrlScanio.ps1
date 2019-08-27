function Connect-UrlScanio {
<#
.SYNOPSIS
Create or update the urlscan.io config file.

.DESCRIPTION
Create or update the urlscan.io config file which contains the API key used within the PSUrlScanio module.

.PARAMETER ApiKey
API key from urlscan.io.

.EXAMPLE
Connect-UrlScanio -ApiKey 2ab2f2a4-1fae-4b8a-b889-0015955fa722
Set urlscan.io API key within config file.

.INPUTS
None. You cannot pipe objects to Connect-UrlScanio.

.OUTPUTS
None. Nothing is returned when calling Connect-UrlScanio.

.NOTES

.LINK
#>
        [CmdletBinding()]
        param (
            [Parameter(Mandatory = $true)]
            [ValidatePattern('[\d\w]{8}-[\d\w]{4}-[\d\w]{4}-[\d\w]{4}-[\d\w]{12}')]
            [string]$ApiKey
        )

        if (!(Test-Path -Path "$($env:AppData)\psurlscanio\urlscankey.json")) {
            try {
                New-Item -Path "$($env:AppData)\psurlscanio\urlscankey.json" -Force
                Write-Verbose "Created config file at $($env:AppData)\psurlscanio\urlscankey.json"
            } catch {
                Write-Error "Unable to create file $($env:AppData)\psurlscanio\urlscankey.json"
                exit
            }
        }

        $Key = ConvertTo-SecureString $ApiKey -AsPlainText -Force | ConvertFrom-SecureString
        $Key | Out-File "$($env:AppData)\psurlscanio\urlscankey.json" -Force
        Write-Verbose "Saved key as secure string to config file"
    }