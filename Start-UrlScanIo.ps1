function Start-UrlScanio {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0)]
        [string]$Url,

        [Parameter(Mandatory = $false)]
        [switch]$Private,

        [Parameter(Mandatory = $false)]
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

        $public = switch ($PSBoundParameters.Public) {
            $true { "on" }
            $false { "off" }
        }
    }

    process {
        $headers = @{
            "Content-Type" = "application/json"
            "API-Key" = $apiKey
        }

        if ($PSBoundParameters.Private) {
            $body = "{
                `"url`": `"$url`"
            }"
        } else {
            $body = "{
                `"url`": `"$url`",
                `"public`": `"on`"
            }"
        }

        $request = Invoke-RestMethod -Uri "https://urlscan.io/api/v1/scan/" -Method Post -Headers $headers -Body $body -ErrorAction:SilentlyContinue
        while ($request.message -ne 'Submission successful') {
            Start-Sleep -Seconds 2.1
            $request = Invoke-RestMethod -Uri "https://urlscan.io/api/v1/scan/" -Method Post -Headers $headers -Body $body -ErrorAction:SilentlyContinue
        }
        $results = Invoke-RestMethod -Uri $request.api
    }

    end {
        if ($PSBoundParameters.Raw) {
            return $results
        }
    }
}