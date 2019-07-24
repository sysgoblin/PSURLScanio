function Search-UrlScanIo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0)]
        [string]$Domain,

        [string]$Raw
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
    }

    end {
        if ($PSBoundParameters.Raw) {
            return $results
        }
    }
}