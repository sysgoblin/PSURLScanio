---
external help file: PSUrlScanio-help.xml
Module Name: PSUrlScanio
online version:
schema: 2.0.0
---

# Get-UrlScanioScreenshot

## SYNOPSIS
Get copy of last screenshot taken by urlscan.io

## SYNTAX

```
Get-UrlScanioScreenshot [-id] <String> -Path <String> [<CommonParameters>]
```

## DESCRIPTION
Retreives copy of screenshot present on urlscan.io result page and saves to the specified location.

## EXAMPLES

### EXAMPLE 1
```
Get-UrlScanioScreenshot -id b14db0aa-013c-4aa9-ad5a-ec947a2278c7 -Path c:\temp
```

Saves screenshot of specified id as C:\temp\b14db0aa-013c-4aa9-ad5a-ec947a2278c7.png

## PARAMETERS

### -id
Unique ID of scan to retrieve the screenshot of.

```yaml
Type: String
Parameter Sets: (All)
Aliases: uuid, _id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Path
Path to save the screenshot file to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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
