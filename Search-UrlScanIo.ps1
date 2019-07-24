function Search-UrlScanio {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0)]
        [string]$Domain,
        [switch]$Raw
    )

    begin {
        #get api key
        if (!(Test-Path -Path "$($env:AppData)\psurlscanio\urlscankey.json")) {
            Throw "PSURLScanio Configuration file not found in `"$($env:AppData)\psurlscanio\urlscankey.json`", please run Set-UrlScanConfig to configure api key."
        } else {
            $config = Get-Content "$($env:AppData)\psurlscanio\urlscankey.json"
            $apiKeySecString = $config | ConvertTo-SecureString
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($apiKeySecString)
            $apiKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
        }
    }

    process {
        $headers = @{
            "Content-Type" = "application/json"
            "API-Key" = $apiKey
        }

        $request = Invoke-RestMethod -Uri "https://urlscan.io/api/v1/search/?q=domain:$domain" -Headers $headers -ErrorAction:SilentlyContinue
        $results = $request.results

        if ($PSBoundParameters.Raw) { # return raw json if called
            $out = $results
        } else {
            $out = $results | % {
                [PSCustomObject]@{
                    TaskDate = $_.task.time
                    Submission = $_.task.method
                    id = $_._id
                    URL = $_.page.url
                    ApiResult = $_.result
                    ResultPage = $_.result -replace '/api/v1'
                }
            } | sort TaskDate
        }
    }

    end {
            return $out
    }
}