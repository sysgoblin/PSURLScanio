function Start-UrlScanioScan {
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
            $out = $results
        } else {
            ''
        }
    }

    end {
        return $out
    }
}