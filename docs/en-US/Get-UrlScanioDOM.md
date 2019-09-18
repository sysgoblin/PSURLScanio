---
external help file: PSUrlScanio-help.xml
Module Name: PSUrlScanio
online version:
schema: 2.0.0
---

# Get-UrlScanioDOM

## SYNOPSIS
Create or update the urlscan.io config file.

## SYNTAX

```
Get-UrlScanioDOM [-id] <String> [-Path <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns raw DOM of the specified scan id by urlscan.io.
If no path is specified DOM will write to console.

## EXAMPLES

### EXAMPLE 1
```
Get-UrlScanioDOM -id b14db0aa-013c-4aa9-ad5a-ec947a2278c7 -Path c:\temp
```

Saves output of specified id as C:\temp\b14db0aa-013c-4aa9-ad5a-ec947a2278c7.txt

## PARAMETERS

### -id
Unique ID of scan to return raw DOM of.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Path
Path to save copy of DOM as txt file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
