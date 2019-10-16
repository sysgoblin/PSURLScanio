function Watch-UrlScanio {
<#
.SYNOPSIS
Live feed of urlscan.io submissions.

.DESCRIPTION
Get a live feed of submissions on urlscan.io returning id, time of submission, IP address and submitted URL.

.EXAMPLE
Watch-UrlScanio | ? Url -match 'login'
Watch urlscan.io for any submitted URL's which contain "login"
#>

    $url = "https://urlscan.io/api/v1/frontpage/?size=10&q=page.ip:* AND task.method:(api%20OR%20manual%20OR%20automatic)"

    while ($true) {
        $req = Invoke-WebRequest -Uri $url -UseBasicParsing
        $resp = $req.Content | ConvertFrom-Json

        $props = @{
            Property =  @{n="id";e={$_.'_id'}},
                        @{n="time";e={$_.task.time}},
                        @{n="ip";e={$_.page.ip}},
                        @{n="Url";e={$_.page.url}}
        }

        $resp.results | ? _id -notin $prevResp._id | select @props
        $prevResp = $resp.results
        Start-Sleep 5
    }
}