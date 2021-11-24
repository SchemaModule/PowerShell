---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertTo-SchemaDefinition.md#convertto-schemadefinition
schema: 2.0.0
---

# ConvertTo-SchemaDefinition

## SYNOPSIS

This function takes an object that has the format of a Schema Definition and
converts it into the schemaDefinition class. It can also return as either the
schemaDefinition class or a json string.

## SYNTAX

```
ConvertTo-SchemaDefinition [[-Definition] <Object>] [-AsJson]  [<CommonParameters>]
```

## DESCRIPTION

This function takes an object that has the format of a Schema Definition and
converts it into the schemaDefinition class. It can also return as either the
schemaDefinition class or a json string.

## EXAMPLES

### Example 1

```powershell
PS C:\> $Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'

ConvertTo-SchemaDefinition -Definition $Schema.definitions.room


type        : object
properties  : @{Id=; Title;Description=}
required    :
```

This example shows how to use the function to convert an object into a schema
class.


## PARAMETERS

### -AsJson

Allows the funciton to return a string in JSON format.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Definition

This is a JSON Schema definition as defined by the json-schema.org (see related
links below). This object is then converted into a PowerShell object that can be
used like any other PowerShell object.

{
 "type": [
  "object"
 ],
 "properties": {
  "Id": {
   "type": "string"
  },
  "Regions": {
   "type": "array",
   "items": {
    "$ref": "#/definitions/Region"
   }
  }
 },
 "required": [
  "Id",
  "Regions"
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### schemaDefinition
This class is really modified object that contains the $schema attribute as well as validation on what values can be present for that attribute. Schema Definition (https://json-schema.org/understanding-json-schema/structuring.html#defs) Schema Keyword (https://json-schema.org/understanding-json-schema/reference/schema.html) Schema Types (https://json-schema.org/understanding-json-schema/reference/type.html)

## NOTES

## RELATED LINKS

[Get-SchemaDocument](https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument)

[New-SchemaProperty](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaProperty.md#new-schemaproperty)

[About Classes](https://github.com/SchemaModule/PowerShell/blob/master/docs/about_Schema_Classes.md)

[JSON Schema Reference](https://json-schema.org/understanding-json-schema/reference/index.html)
