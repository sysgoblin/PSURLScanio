function Get-UrlScanioScreenshot {
<#
.SYNOPSIS
Get copy of last screenshot taken by urlscan.io

.DESCRIPTION
Retreives copy of screenshot present on urlscan.io result page and saves to the specified location.

.PARAMETER id
Unique ID of scan to retrieve the screenshot of.

.PARAMETER Path
Path to save the screenshot file to.

.EXAMPLE
Get-UrlScanioScreenshot -id b14db0aa-013c-4aa9-ad5a-ec947a2278c7 -Path c:\temp
Saves screenshot of specified id as C:\temp\b14db0aa-013c-4aa9-ad5a-ec947a2278c7.png
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0,
        ValueFromPipelineByPropertyName,
        ValueFromPipeline)]
        [ValidatePattern('[\d\w]{8}-[\d\w]{4}-[\d\w]{4}-[\d\w]{4}-[\d\w]{12}')]
        [Alias('uuid', '_id')]
        [string]$id,
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    process {
        if (!($PSBoundParameters.Path)) {
            Write-Error "Please specify path"
        }

        if (Test-Path $Path -PathType Container) {
            try {
                Invoke-WebRequest " https://urlscan.io/screenshots/$id.png" -OutFile "$($Path)\$id.png" -UseBasicParsing
                Write-Verbose "Screenshot saved to $Path\$id.png"
            } catch {
                $_.Exception.Message
            }
        }
    }
}