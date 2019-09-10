function Get-UrlScanioDOM {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$id,
        [string]$Path
    )

    process {
        if ($PSBoundParameters.Path) {
            if (Test-Path $Path -PathType Container) {
                try {
                    Invoke-WebRequest "https://urlscan.io/dom/$id/" -OutFile "$id.txt"
                    Write-Verbose "DOM saved to $Path\$id.txt"
                } catch {
                    $_.Exception.Message
                }
            }
        }

        $dom = Invoke-WebRequest "https://urlscan.io/dom/$id/"

        return $dom.Content
    }
}