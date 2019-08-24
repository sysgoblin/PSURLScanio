---
external help file: PSUrlScanio-help.xml
Module Name: PSUrlScanio
online version:
schema: 2.0.0
---

# Connect-UrlScanio

## SYNOPSIS
Create or update the urlscan.io config file.

## SYNTAX

```
Connect-UrlScanio [-ApiKey] <String> [<CommonParameters>]
```

## DESCRIPTION
Create or update the urlscan.io config file which contains the API key used within the PSUrlScanio module.

## EXAMPLES

### EXAMPLE 1
```
Connect-UrlScanio -ApiKey 2ab2f2a4-1fae-4b8a-b889-0015955fa722
```

Set urlscan.io API key within config file.

## PARAMETERS

### -ApiKey
API key from urlscan.io.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects to Connect-UrlScanio.
## OUTPUTS

### None. Nothing is returned when calling Connect-UrlScanio.
## NOTES

## RELATED LINKS
