function Search-UrlScanio {
<#
.SYNOPSIS
Search urlscan.io results.

.DESCRIPTION
Search urlscan.io using the provided parameters or providing a filter using Elasticsearch Query String syntax
(https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)

Params specified are combined to form a valid filter string.

.PARAMETER Domain
Domain to return results for (equivilent to page.domain).

.PARAMETER IP
Limit results or return those which are related to the IP provided.

.PARAMETER ASN
Limit results or return those which are related to the ASN provided.

.PARAMETER ASNName
Limit results or return those which are related to the ASN Name provided.

.PARAMETER Filename
Limit results or return those which are related to the file name provided.

.PARAMETER Hash
Limit results or return those which are related to the hash provided.

.PARAMETER Server
Limit results or return those which are related to the server provided.

.PARAMETER Filter
Filter string.

.PARAMETER Limit
Number of results to return (default 100).

.PARAMETER All
Return all possible results up to a maximum of 10000. (Limit set by urlscan.io)

.PARAMETER Raw
Return results as raw json.

.PARAMETER Specific
Only return results where the page domain contains the specified domain. Default behaiviour is to return results where domain is called in any part of the page response.

.EXAMPLE
Search-UrlScanio -Domain google.com -Limit 10
Returns last 10 scans completed on the domain google.com.

.INPUTS
None. You cannot pipe objects to Search-UrlScanio.

.OUTPUTS
System.String. Data can be returned as a json string.
System.Object. Data can be returned as an Object.

.NOTES

.LINK
#>

    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = 'Filter')]
        [string]$Filter,

        [Parameter(ParameterSetName = 'Params')]
        [string]$Domain,
        [Parameter(ParameterSetName = 'Params')]
        [string]$IP,
        [Parameter(ParameterSetName = 'Params')]
        [string]$ASN,
        [Parameter(ParameterSetName = 'Params')]
        [string]$ASNName,
        [Parameter(ParameterSetName = 'Params')]
        [string]$Filename,
        [Parameter(ParameterSetName = 'Params')]
        [string]$Hash,
        [Parameter(ParameterSetName = 'Params')]
        [string]$Server,

        [ValidateRange(1,10000)]
        [int]$Limit = 100,

        [switch]$All,

        [ValidateSet('json','Object')]
        [string]$Raw,

        [switch]$Specific,

        [Parameter(ParameterSetName = 'Sort')]
        [Parameter(ParameterSetName = 'Params')]
        [Parameter(ParameterSetName = 'Filter')]
        [ValidateSet('Date', 'URL', 'Country', 'IP', 'ASN', 'Score')]
        [string]$SortBy,

        [Parameter(ParameterSetName = 'Sort')]
        [Parameter(ParameterSetName = 'Params')]
        [Parameter(ParameterSetName = 'Filter')]
        [switch]$Descending,

        [Parameter(ParameterSetName = 'Sort')]
        [Parameter(ParameterSetName = 'Params')]
        [Parameter(ParameterSetName = 'Filter')]
        [switch]$Ascending
    )

    process {
        if ($PSBoundParameters.Count -eq 0) {
            Write-Error "Please provide search criteria."
        }

        if ($PSCmdlet.ParameterSetName -eq 'Filter') {
            $query = $filter
        } elseif ($PSCmdlet.ParameterSetName -eq 'Params') {
            # query builder
            $query = @()
            $PSBoundParameters.GetEnumerator() | ForEach-Object {
                try {
                    $k = $_.Key.ToLower()
                    $v = $_.Value.ToLower()

                    switch ($_.Key) {
                        Domain { if ($PSBoundParameters.Specific) { $k = 'page.domain' }; $query += $k + ':' + $v }
                        IP { $query += $k + ':' + $v }
                        ASN { $query += $k + ':' + $v }
                        ASNName { $query += $k + ':' + $v }
                        Filename { $query += $k + ':' + $v }
                        Hash { $query += $k + ':' + $v }
                        Server { $query += $k + ':' + $v }
                    }
                } catch {
                    "Carry on" > $null # do nothing if error
                }
            }

            if ($query.count -ge 2) {
                $query = $query -join ' AND '
            }
        }

        # sorting
        if ($PSBoundParameters.SortBy) {
            switch ($SortBy) {
                'Date' { $sortField = 'date' }
                'URL' { $sortField = 'page.url' }
                'Country' { $sortField = 'page.country' }
                'IP' { $sortField = 'page.IP' }
                'ASN' { $sortField = 'page.ASN' }
                'Score' { $sortField = '_score' }
            }
            $sortOrder = 'desc'
            if ($PSBoundParameters.Ascending) { $sortOrder = 'asc' }
        } else {
            $sortField = 'date'
            $sortOrder = 'desc'
        }

        if ($PSBoundParameters.All) {
            Write-Verbose "Getting results up to limit of 10000"
            $url = "https://urlscan.io/api/v1/search/?q=$query&size=1"
            $request = Invoke-RestMethod -Uri $url -ErrorAction:Stop
            $totalCount = $request.total
            if ($totalCount -gt 10000) {
                Write-Output "[INFO]`t$totalCount possible results, retrieving maximum results allowed (10000)"
                $Limit = 10000
            } else {
                Write-Verbose "Retrieving $totalCount results"
                $Limit = $totalCount
            }
        }

        $url = "https://urlscan.io/api/v1/search/?q=$query&size=$Limit&sort_field=$sortField&sort_order=$sortOrder"
        $request = Invoke-RestMethod -Uri $url -ErrorAction:Stop
        $results = $request.results

        if ($PSBoundParameters.Raw) { # return raw json if called
            switch ($Raw) {
                json {$out = $results | ConvertTo-Json}
                Object {$out = $results}
            }
        } else {
            $out = $results | ForEach-Object {
                [PSCustomObject]@{
                    TaskDate = $_.task.time
                    Submission = $_.task.method
                    id = $_._id
                    URL = $_.page.url
                    ApiResult = $_.result
                    ResultPage = $_.result -replace '/api/v1'
                }
            } | Sort-Object TaskDate -Descending
        }
    }

    end {
        return $out
    }
}