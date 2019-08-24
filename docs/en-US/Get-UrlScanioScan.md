---
external help file: PSUrlScanio-help.xml
Module Name: PSUrlScanio
online version:
schema: 2.0.0
---

# Get-UrlScanioScan

## SYNOPSIS
Get urlscan.io scan results.

## SYNTAX

```
Get-UrlScanioScan [-uuid] <String> [-Raw] [<CommonParameters>]
```

## DESCRIPTION
Get urlscan.io scan results for the provided uuid.
Returns results as an object by default.

## EXAMPLES

### EXAMPLE 1
```
Get-UrlScanioScan -uuid b14db0aa-013c-4aa9-ad5a-ec947a2278c7
```

Get urlscan.io report for the scan with uuid b14db0aa-013c-4aa9-ad5a-ec947a2278c7

## PARAMETERS

### -uuid
UUID of scan to get details on.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Raw
Returns data as raw json.

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

### System.String. UUID's of scans can be piped to Get-UrlScanioScan.
### System.Object. Objects containing a property of a scans UUID can be piped to Get-UrlScanioScan.
## OUTPUTS

### System.String. Data can be returned as a json string.
### System.Object. Data can be returned as an Object.
## NOTES

## RELATED LINKS
