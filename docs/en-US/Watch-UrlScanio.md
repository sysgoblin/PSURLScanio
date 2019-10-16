---
external help file: PSUrlScanio-help.xml
Module Name: PSUrlScanio
online version:
schema: 2.0.0
---

# Watch-UrlScanio

## SYNOPSIS
Live feed of urlscan.io submissions.

## SYNTAX

```
Watch-UrlScanio
```

## DESCRIPTION
Get a live feed of submissions on urlscan.io returning id, time of submission, IP address and submitted URL.

## EXAMPLES

### EXAMPLE 1
```
Watch-UrlScanio | ? Url -match 'login'
```

Watch urlscan.io for any submitted URL's which contain "login"

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
