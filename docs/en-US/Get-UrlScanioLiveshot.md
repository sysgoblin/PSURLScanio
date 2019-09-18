---
external help file: PSUrlScanio-help.xml
Module Name: PSUrlScanio
online version:
schema: 2.0.0
---

# Get-UrlScanioLiveshot

## SYNOPSIS
Create or update the urlscan.io config file.

## SYNTAX

```
Get-UrlScanioLiveshot [-URL] <String[]> [-Path] <String> [[-Height] <Int32>] [[-Width] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Get live screenshot of specified domain or URL and download to specified directory.
Screenshots saved in png format.

## EXAMPLES

### EXAMPLE 1
```
Get-UrlScanioLiveshot -URL google.com -Path c:\temp
```

Download screenshot of google.com to c:\temp.
File will be saved as c:\temp\google.com.png

## PARAMETERS

### -URL
URL or domain to retreive live screenshot.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: domain

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Directory to save .png of screenshot to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Height
Height of screenshot in pixels.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 1200
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
Width of screenshot in pixels.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 1600
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
