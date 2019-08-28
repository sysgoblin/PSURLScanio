function Get-UrlScanioLiveshot {
<#
.SYNOPSIS
Get live screenshot of specified URL.

.DESCRIPTION
Get live screenshot of specified domain or URL and download to specified directory. Screenshots saved in png format.

.PARAMETER URL
URL or domain to retreive live screenshot.

.PARAMETER Path
Directory to save .png of screenshot to.

.PARAMETER Height
Height of screenshot in pixels.

.PARAMETER Width
Width of screenshot in pixels.

.EXAMPLE
Get-UrlScanioLiveshot -URL google.com -Path c:\temp
Download screenshot of google.com to c:\temp. File will be saved as c:\temp\google.com.png
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName)]
        [Alias('domain')]
        [string[]]$URL,

        [Parameter(Mandatory = $true)]
        [string]$Path,

        [int]$Height = 1200,
        [int]$Width = 1600
    )

    process {
        if (!(Test-Path $Path -PathType Container)) {
            Write-Error "Please specify directory for output. File will be named after the URL provided"
        }

        if ($URL -notmatch 'http') {
            $URL = 'http://' + $URL
        }

        $outFile = "$($URL -replace 'http.*:\/\/','' -replace '\/', '.')" + ".png"

        Invoke-WebRequest "https://urlscan.io/liveshot/?width=$Width&height=$Height&url=$URL" -OutFile $Path\$outFile -TimeoutSec 15
    }
}