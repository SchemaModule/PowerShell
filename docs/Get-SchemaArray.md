---
external help file: schema-help.xml
Module Name: schema
online version:
schema: 2.0.0
---

# Get-SchemaArray

## SYNOPSIS
This function returns the object from an array within the Json Schema.

## SYNTAX

```
Get-SchemaArray [[-SchemaDocument] <Object>] [<CommonParameters>]
```

## DESCRIPTION
This function returns the object from an array within the Json Schema. This function expands the array and returns a
PowerShell representation of the object.

## EXAMPLES

### Example 1
```powershell
PS C:\> $SchemaDocument = 'https://gist.githubusercontent.com/jeffpatton1971/c2d3ee98a37766a2784ccd626b9b8ca2/raw/f2a92166f52e067542964216a7618b8d2c408489/array.json' |Get-SchemaDocument
PS C:\> $SchemaDocument.properties.products |Get-SchemaArray

price dimensions tags name
----- ---------- ---- ----
    0            {}
```

This example reads in a Json schema from the internet and then passes in a specific array item within the schema.

## PARAMETERS

### -SchemaDocument
This should be the output of Get-SchemaDocument. For simple JSON schema's this could be passed along the pipeline
to this function.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS
### System.Object
This should always be the output of the Get-SchemaDocument function.

## OUTPUTS
### System.Object
A PowerShell representation of the referenced schema

## NOTES

## RELATED LINKS
[Get-SchemaDocument](https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument)