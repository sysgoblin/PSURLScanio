function Get-UrlScanioScreenshot {
    [CmdletBinding()]
    param (
        [string]$id,
        [string]$Path
    )

    process {
        if (!($PSBoundParameters.Path)) {
            Write-Error "Please specify path"
        }

        if (Test-Path $Path -PathType Container) {
            try {
                Invoke-WebRequest " https://urlscan.io/screenshots/$id.png" -OutFile "$id.png"
                Write-Verbose "Screenshot saved to $Path\$id.png"
            } catch {
                $_.Exception.Message
            }
        }
    }
}