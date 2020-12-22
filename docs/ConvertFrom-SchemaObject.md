---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertFrom-SchemaObject.md#convertfrom-schemaobject
schema: 2.0.0
---

# ConvertFrom-SchemaObject

## SYNOPSIS

This function takes the schemaObject object and converts it into a PowerShell object
that can be nicely output as a JSON string.

## SYNTAX

```
ConvertFrom-SchemaObject [-Object] <Object> [[-Depth] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

This function takes the schemaObject object and converts it into a PowerShell object
that can be nicely output as a JSON string. This function is useful when you need
to output the JSON schema as a JSON object. This would have the effect of
creating an empty JSON document based on the schema that was provided.

## EXAMPLES

### Example 1

```powershell
PS C:\> $Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'

ConvertFrom-SchemaObject -Object $Schema


$schema        : http://json-schema.org/draft-07/schema#
$id            : http://example.com/example.json
width          :
depth          :
closet         : False
room           :
contents       : {System.Object}
exterioraccess : False
```

Take an object defined in a JSON schema and convert it into a custom PowerShell
object.

## PARAMETERS

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

### -Object

This is a JSON Schema object as defined by the json-schema.org (see related links
below). This object is then converted into a PowerShell object that can be used
like any other PowerShell object.

{
 "type": "object",
 "schema": "<http://json-schema.org/draft-07/schema>#",
 "additionalProperties": true,
 "definitions": null,
 "id": "http://example.com/example.json",
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[ConvertFrom-SchemaObject](https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertFrom-SchemaObject.md#convertfrom-schemaobject)

[JSON Schema Object](https://json-schema.org/understanding-json-schema/reference/object.html)
