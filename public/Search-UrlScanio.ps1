function Search-UrlScanio {
    [CmdletBinding()]
    param (
        [string]$Domain,
        [string]$IP,
        [string]$ASN,
        [string]$ASNName,
        [string]$Filename,
        [string]$Hash,
        [string]$Server,
        [string]$Filter,
        [int]$Limit = 100,
        [switch]$Raw
    )

    begin {
        Get-UrlScanIoApiKey
    }

    process {
        $headers = @{
            "Content-Type" = "application/json"
            "API-Key" = $apiKey
        }

        # query builder
        $query = @()
        $PSBoundParameters.GetEnumerator() | % {
            if (($_.Key -ne 'Limit') -and ($_.Key -ne 'Raw') -and ($_.Key -ne 'Debug')) {
                $k = $_.Key.ToLower()
                $v = $_.Value.ToLower()

                if ($_.Key -eq 'Domain') { $k = 'page.domain' }
                $query += $k + ':' + $v
            }
        }

        if ($query.count -ge 2) {
            $query = $query -join ' AND '
        }

        $url = "https://urlscan.io/api/v1/search/?q=$query" + "&size=$Limit"
        $request = Invoke-RestMethod -Uri $url -Headers $headers -ErrorAction:Stop
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