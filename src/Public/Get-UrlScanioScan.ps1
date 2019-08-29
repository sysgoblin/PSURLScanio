function Get-UrlScanioScan {
<#
.SYNOPSIS
Get urlscan.io scan results.

.DESCRIPTION
Get urlscan.io scan results for the provided id. Returns results as an object by default or -DataType can be used to access subsets of data.

.PARAMETER id
Guid of scan to get details on.

.PARAMETER DataType
Data type to return. Provides quick access to specific  subsets of data for interrogation.

.EXAMPLE
Get-UrlScanioScan -uuid b14db0aa-013c-4aa9-ad5a-ec947a2278c7
Get urlscan.io report for the scan with uuid b14db0aa-013c-4aa9-ad5a-ec947a2278c7

.INPUTS
System.String. UUID's of scans can be piped to Get-UrlScanioScan.
System.Object. Objects containing a property of a scans UUID can be piped to Get-UrlScanioScan.

.OUTPUTS
System.String. Data can be returned as a json string.
System.Object. Data can be returned as an Object.

.NOTES

.LINK
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
        Position = 0,
        ValueFromPipelineByPropertyName,
        ValueFromPipeline)]
        [ValidatePattern('[\d\w]{8}-[\d\w]{4}-[\d\w]{4}-[\d\w]{4}-[\d\w]{12}')]
        [Alias('uuid', '_id')]
        [string[]]$id,

        [Parameter(ParameterSetName = 'data')]
        [ValidateSet('Links','Hashes','Cookies','Certificates','Verdict')]
        [string]$DataType,

        [Parameter(ParameterSetName = 'data')]
        [switch]$IncludeTaskDetails
    )

    process {
        $request = Invoke-RestMethod -Uri "https://urlscan.io/api/v1/result/$id" -ErrorAction:SilentlyContinue

        if ($PSBoundParameters.DataType) {
            # output basic task deets
            if ($PSBoundParameters.IncludeTaskDetails) {
                $task = $request.task | select uuid, time, url, reportURL
            }
            $props = @{}

            switch ($DataType) {
                Links {
                    if ($task) {
                        $props.Property +=  @{n="id";e={$task.uuid}},
                                            @{n="time";e={$task.time}},
                                            @{n="taskUrl";e={$task.url}}
                    }
                    $props.Property += 'href','text'

                    $out = $request.data.links | select @props

                    if ($out.count -eq 0) {
                        Write-Error "No links found for task $($task.uuid)"
                    }
                }
                Hashes {
                    $hashes = $request.data.requests.response.Where({$_.hash})
                    if ($task) {
                        $props.Property +=  @{n="id";e={$task.uuid}},
                                            @{n="time";e={$task.time}},
                                            @{n="taskUrl";e={$task.url}}
                    }
                    $props.Property +=  @{n="type";e={$_.type}},
                                        @{n="size";e={$_.size}},
                                        @{n="hash";e={$_.hash}},
                                        @{n="url";e={$_.response.url}}

                    $out = $hashes | select @props
                }
                Cookies {
                    [datetime]$origin = '1970-01-01 00:00:00'
                    if ($task) {
                        $props.Property +=  @{n="id";e={$task.uuid}},
                                            @{n="time";e={$task.time}},
                                            @{n="taskUrl";e={$task.url}}
                    }
                    $props.Property +=  'name',
                                        'value',
                                        'domain',
                                        'path',
                                        @{n='expires';e={$origin.AddSeconds($_.expires)}},
                                        'size',
                                        'httpOnly',
                                        'secure',
                                        'session'

                    $out = $request.data.cookies | select @props

                    if ($out.count -eq 0) {
                        Write-Error "No cookies found for task $($task.uuid)"
                    }
                }
                Certificates {
                    [datetime]$origin = '1970-01-01 00:00:00'
                    if ($task) {
                        $props.Property +=  @{n="id";e={$task.uuid}},
                                            @{n="time";e={$task.time}},
                                            @{n="taskUrl";e={$task.url}}
                    }
                    $props.Property +=  'subjectName',
                                        'issuer',
                                        @{n='validFrom';e={$origin.AddSeconds($_.validFrom)}},
                                        @{n='validTo';e={$origin.AddSeconds($_.validTo)}}

                    $out = $request.lists.certificates | select @props
                }
                Verdict {
                    $vo = $request.verdicts.overall
                    $ve = $request.verdicts.engines
                    $out = @{}

                    if ($task) {
                        $out += @{
                            id = $task.uuid
                            time = $task.time
                            taskUrl = $task.url
                        }
                    }

                    $out += @{
                        malicious = $vo.malicious
                        overallScore = $vo.score
                        tags = (@($vo.tags + $ve.verdicts.categories) | select -Unique) -join ', '
                        brands = $vo.brands -join ', '
                        engineHits = $ve.malicious -join ', '
                    }

                }
            }
        } else {
            $out = $request
        }

        return $out
    }
}