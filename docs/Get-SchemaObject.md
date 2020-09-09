---
external help file: schema-help.xml
Module Name: schema
online version:
schema: 2.0.0
---

# Get-SchemaObject

## SYNOPSIS
This function returns an object from the Json Schema.

## SYNTAX

```
Get-SchemaObject [[-SchemaDocument] <Object>] [<CommonParameters>]
```

## DESCRIPTION
This function returns an object from the Json Schema. By passing in a specific data structure and get back a
PowerShell representation of the structure.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-SchemaObject -SchemaDocument $SchemaDocument

price dimensions tags name
----- ---------- ---- ----
    0            {}
```

This example shows how to pass in an object to the function.

### Example 2
```powershell
PS C:\> 'https://gist.githubusercontent.com/jeffpatton1971/c2d3ee98a37766a2784ccd626b9b8ca2/raw/a112c9119cce507c2b4e115c35afc6c26f63ffc7/schema.json' |Get-SchemaDocument |Get-SchemaObject

price dimensions tags name
----- ---------- ---- ----
    0            {}
```

A slightly more complex example, showing the ability to pass the schema along the pipeline to other functions.

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