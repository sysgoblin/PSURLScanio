---
external help file: PSUrlScanio-help.xml
Module Name: PSUrlScanio
online version:
schema: 2.0.0
---

# Start-UrlScanioScan

## SYNOPSIS
Start scan of URL on urlscan.io

## SYNTAX

```
Start-UrlScanioScan [-Url] <String> [-Private] [-ShowResults <Boolean>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION
Start-UrlScanioScan triggers a scan of the specified URL.
By default progress will be written to the console until the scan is complete and the results returned as an object.

## EXAMPLES

### EXAMPLE 1
```
Start-UrlScanioScan -Url www.google.com
```

Trigger a scan of the URL "www.google.com".
Results will be returned when the scan is complete.

### EXAMPLE 2
```
Start-UrlScanioScan -Url www.google.com -ShowResults:$false
```

Trigger a scan of the URL "www.google.com".
A url for the report will be returned while the scan takes place.

## PARAMETERS

### -Url
URL to scan.

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

### -Private
Use if the scan should be private.

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

### -ShowResults
True by default, set to false if you just want the report URL.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
Returns results as a raw json string.

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

### None. You cannot pipe objects to Start-UrlScanioScan.
## OUTPUTS

### System.String. Data can be returned as a json string.
### System.Object. Data can be returned as an Object.
## NOTES

## RELATED LINKS
