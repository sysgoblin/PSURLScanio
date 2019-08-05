function Get-UrlScanioScan {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0)]
        [string]$uuid
    )

    begin {
        Get-UrlScanIoApiKey
    }

    process {
        # send api call
        $request = Invoke-RestMethod -Uri "https://urlscan.io/api/v1/result/$uuid" -Headers $headers -ErrorAction:SilentlyContinue
    }

    end {
        return $request
    }
}