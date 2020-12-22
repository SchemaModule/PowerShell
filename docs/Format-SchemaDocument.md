---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/Format-SchemaDocument.md#format-schemadocument
schema: 2.0.0
---

# Format-SchemaDocument

## SYNOPSIS

A simple schema linter

## SYNTAX

```
Format-SchemaDocument [-json] <String> [<CommonParameters>]
```

## DESCRIPTION

A simple schema linter to output classes into a format that the schema definition
would expect. Limitations of PowerShell prevent property names from starting
with '$' so the linter updates values like id,schema,definitions,references to
be pre-fixed with a '$'.

## EXAMPLES

### Example 1

```powershell
$Schema |ConvertTo-Json -Depth 1 |Format-SchemaDocument
{
  "type": "object",
  "$schema": "http://json-schema.org/draft-07/schema#",
  "additionalProperties": true,
  "$definitions": null,
  "$id": "http://example.com/example.json",
  "properties": {
    "width": "schemaString",
    "depth": "schemaString",
    "closet": "schemaBoolean",
    "room": "schemaString",
    "contents": "schemaArray",
    "exterioraccess": "schemaBoolean"
  },
  "required": [
    "room",
    "width",
    "depth",
    "closet",
    "exterioraccess",
    "contents"
  ],
  "title": "The root schema",
  "description": "The root schema comprises the entire JSON document.",
  "default": {

  }
}
```

This example shows how to use this function, we have restricted the
ConvertTo-Json Cmdlet to a depth of 1 to keep this help readable.

## PARAMETERS

### -json

This is a json string object to be formatted.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Format-SchemaDocument](https://github.com/SchemaModule/PowerShell/blob/master/docs/Format-SchemaDocument.md#format-schemadocument)
