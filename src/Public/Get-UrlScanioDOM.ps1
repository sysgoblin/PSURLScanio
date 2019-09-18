function Get-UrlScanioDOM {
<#
.SYNOPSIS
Return raw DOM of web page scanned by urlscan.io

.DESCRIPTION
Returns raw DOM of the specified scan id by urlscan.io. If no path is specified DOM will write to console.

.PARAMETER id
Unique ID of scan to return raw DOM of.

.PARAMETER Path
Path to save copy of DOM as txt file.

.EXAMPLE
Get-UrlScanioDOM -id b14db0aa-013c-4aa9-ad5a-ec947a2278c7 -Path c:\temp
Saves output of specified id as C:\temp\b14db0aa-013c-4aa9-ad5a-ec947a2278c7.txt
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0,
        ValueFromPipelineByPropertyName,
        ValueFromPipeline)]
        [ValidatePattern('[\d\w]{8}-[\d\w]{4}-[\d\w]{4}-[\d\w]{4}-[\d\w]{12}')]
        [string]$id,
        [string]$Path
    )

    process {
        if ($PSBoundParameters.Path) {
            if (Test-Path $Path -PathType Container) {
                try {
                    Invoke-WebRequest "https://urlscan.io/dom/$id/" -OutFile "$id.txt" -UseBasicParsing
                    Write-Verbose "DOM saved to $Path\$id.txt"
                } catch {
                    $_.Exception.Message
                }
            }
        }

        $dom = Invoke-WebRequest "https://urlscan.io/dom/$id/" -UseBasicParsing

        return $dom.Content
    }
}