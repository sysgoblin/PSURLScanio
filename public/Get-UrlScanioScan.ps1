function Get-UrlScanioScan {
<#
.SYNOPSIS
Get urlscan.io scan results

.DESCRIPTION
Get urlscan.io scan results for the provided uuid. Returns as converted json by default.

.PARAMETER uuid
UUID of scan to get details on

.PARAMETER Raw
Returns data as raw json

.EXAMPLE
Get-UrlScanioScan -uuid b14db0aa-013c-4aa9-ad5a-ec947a2278c7
Get urlscan.io report for the scan with uuid b14db0aa-013c-4aa9-ad5a-ec947a2278c7
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0,
        ValueFromPipelineByPropertyName)]
        [ValidatePattern('[\d\w]{8}-[\d\w]{4}-[\d\w]{4}-[\d\w]{4}-[\d\w]{12}')]
        [string]$uuid,

        [Parameter(Mandatory = $false)]
        [switch]$Raw
    )

    begin {
        Get-UrlScanioApiKey
    }

    process {
        $headers = @{
            "Content-Type" = "application/json"
            "API-Key" = $apiKey
        }
        # send api call
        $request = Invoke-RestMethod -Uri "https://urlscan.io/api/v1/result/$uuid" -Headers $headers -ErrorAction:SilentlyContinue

        if ($PSBoundParameters.Raw) {
            $request = $request | ConvertTo-Json
        }
    }

    end {
        return $request
    }
}