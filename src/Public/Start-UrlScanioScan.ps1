function Start-UrlScanioScan {
<#
.SYNOPSIS
Start scan of URL on urlscan.io

.DESCRIPTION
Start-UrlScanioScan triggers a scan of the specified URL.
By default progress will be written to the console until the scan is complete and the results returned as an object.

.PARAMETER Url
URL to scan.

.PARAMETER Private
Use if the scan should be private.

.PARAMETER ShowResults
True by default, set to false if you just want the report URL.

.PARAMETER Raw
Returns results as a raw json string.

.EXAMPLE
Start-UrlScanioScan -Url www.google.com
Trigger a scan of the URL "www.google.com". Results will be returned when the scan is complete.

.EXAMPLE
Start-UrlScanioScan -Url www.google.com -ShowResults:$false
Trigger a scan of the URL "www.google.com". A url for the report will be returned while the scan takes place.

.INPUTS
None. You cannot pipe objects to Start-UrlScanioScan.

.OUTPUTS
System.String. Data can be returned as a json string.
System.Object. Data can be returned as an Object.

.NOTES

.LINK
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0)]
        [string]$Url,

        [Parameter(Mandatory = $false)]
        [switch]$Private,

        [Parameter(Mandatory = $false)]
        [bool]$ShowResults = $true,

        [Parameter(Mandatory = $false)]
        [switch]$Raw
    )

    begin {
        Get-UrlScanIoApiKey
    }

    process {
        $public = switch ($PSBoundParameters.Public) {
            $true { "on" }
            $false { "off" }
        }

        # construct request
        if ($PSBoundParameters.Private) {
            $body = "{`"url`": `"$url`"}"
        } else {
            $body = "{`"url`": `"$url`",`"public`": `"on`"}"
        }

        $headers = @{
            "Content-Type" = "application/json"
            "API-Key" = $apiKey
        }

        # send api call
        $request = Invoke-RestMethod -Uri "https://urlscan.io/api/v1/scan/" -Method Post -Headers $headers -Body $body -ErrorAction:SilentlyContinue

        if ($PSBoundParameters.ShowResults -eq $false) {
            $out = $request
        } else {
            $progTimer = 0
            while (!($results)) {
                # wait for results to come in
                Write-Progress -Activity 'Scanning on URLScan.io' -Status "Time elapsed: $progTimer"
                try { # try/catch block to supress errors until scan completes
                    $results = Invoke-RestMethod -Uri $request.api -ErrorAction:Stop
                } catch {}
                Start-Sleep -Seconds 2
                $progTimer += 2
            }

            if ($PSBoundParameters.Raw) { # return raw json if called
                $out = $results | ConvertTo-Json
            } else {
                $out = $results
            }
        }
    }

    end {
        return $out
    }
}