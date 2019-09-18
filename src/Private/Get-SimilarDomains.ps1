function Get-SimilarDomains {
    param (
        [string]$id
    )

    $html = Invoke-WebRequest "https://urlscan.io/result/$id/related/" -UseBasicParsing

    $links = $html.links

    $p1 = (0..($links.count-1)) | ? {$links.class[$_] -match 'btn-primary'}
    $p2 = (0..($links.count-1)) | ? {$links.class[$_] -match 'btn-default'}

    $similar = $links[($p1)..($p2[0])] | ? title | select @{n="Domain";e={$_.title}}, @{n="id";e={$_.href -replace '/|result'}}, @{n="ResultPage";e={"https://urlscan.io" + $_.href}}
    # $sameDomain = $links.title[($p2[0])..($p2[1])]
    # $sameIp = $links.title[($p2[1])..($p2[2])]
    # $sameASN = $links.title[($p2[2])..($p2[3])]
    # $sameUrl = $links.title[($p2[3])..($p2[4])]

    return $similar
}