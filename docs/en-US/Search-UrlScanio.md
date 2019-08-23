---
external help file: PSUrlScanio-help.xml
Module Name: PSUrlScanio
online version:
schema: 2.0.0
---

# Search-UrlScanio

## SYNOPSIS
Search urlscan.io

## SYNTAX

### Filter
```
Search-UrlScanio [-Filter <String>] [-Limit <Int32>] [-Raw] [<CommonParameters>]
```

### Params
```
Search-UrlScanio [-Domain <String>] [-IP <String>] [-ASN <String>] [-ASNName <String>] [-Filename <String>]
 [-Hash <String>] [-Server <String>] [-Limit <Int32>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION
Search urlscan.io using the provided parameters or providing a filter using Elasticsearch Query String syntax
(https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html)

Params specified are combined to form a valid filter string.

## EXAMPLES

### EXAMPLE 1
```
Search-UrlScanio -Domain google.com -Limit 10
```

Returns last 10 scans completed on the domain google.com

## PARAMETERS

### -Filter
Filter string

```yaml
Type: String
Parameter Sets: Filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
Domain to return results for (equivilent to page.domain)

```yaml
Type: String
Parameter Sets: Params
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IP
Limit results or return those which are related to the IP provided

```yaml
Type: String
Parameter Sets: Params
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ASN
Limit results or return those which are related to the ASN provided

```yaml
Type: String
Parameter Sets: Params
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ASNName
Limit results or return those which are related to the ASN Name provided

```yaml
Type: String
Parameter Sets: Params
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filename
Limit results or return those which are related to the file name provided

```yaml
Type: String
Parameter Sets: Params
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hash
Limit results or return those which are related to the hash provided

```yaml
Type: String
Parameter Sets: Params
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Limit results or return those which are related to the server provided

```yaml
Type: String
Parameter Sets: Params
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit
Number of results to return (default 100)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
Return results as raw json

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS