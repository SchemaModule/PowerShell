---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertFrom-SchemaArray.md#convertfrom-schemaarray
schema: 2.0.0
---

# ConvertFrom-SchemaArray

## SYNOPSIS

This function takes the schemaArray object and converts it into a PowerShell array
that can be nicely output as a JSON string.

## SYNTAX

```
ConvertFrom-SchemaArray [-Array] <Object> [[-Depth] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

This function takes the schemaArray object and converts it into a PowerShell array
that can be nicely output as a JSON string. This function is useful when you need
to output the JSON schema as a JSON object. This would have the effect of
creating an empty JSON document based on the schema that was provided.

## EXAMPLES

### Example 1

```powershell
PS C:\> $Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'

ConvertFrom-SchemaArray -Array $Schema.Find('printers')

brand capability model type
----- ---------- ----- ----
```

Take an object defined in a JSON schema and convert it into a custom PowerShell
object.

## PARAMETERS

### -Array

This is a JSON Schema Array as defined by the json-schema.org (see related links
below). This array is then converted into a PowerShell object that can be used
like any other PowerShell object.

{
 "type": "array",
 "additionalItems": true,
 "id": "#/properties/contents/items/anyOf/0/properties/printers",
 "items": {
  "anyOf": [{
   "type": "object",
   "additionalProperties": true,
   "id": "#/properties/contents/items/anyOf/0/properties/printers/items/anyOf/0",
   "properties": "System.Collections.Hashtable",
   "required": "type capability brand model",
   "title": "The first anyOf schema",
   "description": "An explanation about the purpose of this instance.",
   "default": "",
   "enum": null
  }]
 },
 "title": "The printers schema",
 "description": "An explanation about the purpose of this instance.",
 "default": [
 ]
}

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth

The Depth parameter defines the number of levers that are recursed in order to
create the object.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object[]

## NOTES

## RELATED LINKS

[ConvertFrom-SchemaArray](https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertFrom-SchemaArray.md#convertfrom-schemaarray)

[JSON Schema Array](https://json-schema.org/understanding-json-schema/reference/array.html)
