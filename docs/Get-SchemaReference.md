---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaReference.md#get-schemareference
schema: 2.0.0
---

# Get-SchemaReference

## SYNOPSIS

A function to follow the ref keyword and return the referenced schema

## SYNTAX

```
Get-SchemaReference [[-Reference] <Uri>] [<CommonParameters>]
```

## DESCRIPTION

A function to follow the ref keyword and return the referenced schema. This
function is mostly used in conjunction with Get-SchemaDefinition and
Get-SchemaDocument when processing a larger schema that has been broken into
multiple files.

## EXAMPLES

### Example 1

```powershell
Get-SchemaReference -Reference "https://example.com/schemas/inventory.json" |fl *


type                 : object
schema               : http://json-schema.org/draft-04/schema#
definitions          :
id                   : https://example.com/schemas/inventory.json
properties           : {rooms}
required             : {rooms}
additionalProperties : False
title                : Room Inventory Schema
description          :
default              :
```

This example shows how you might use this to return a referenced schema

## PARAMETERS

### -Reference

A URL to where this reference is found.

```yaml
Type: System.Uri
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

### System.Uri
## OUTPUTS

### schemaDocument
This class is really modified object that contains the $schema attribute as well as validation on what values can be present for that attribute. Schema Object (https://json-schema.org/understanding-json-schema/reference/object.html) Schema Keyword (https://json-schema.org/understanding-json-schema/reference/schema.html) Schema Types (https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaString
The string type is used for strings of text. It may contain Unicode characters. Schema String (https://json-schema.org/understanding-json-schema/reference/string.html) Schema Types (https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaInteger
The integer type is used for integral numbers. In PowerShell this is an int32 Schema Integer (http://json-schema.org/understanding-json-schema/reference/numeric.html#integer) Schema Types (https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaNumber
The number type is used for any numeric type, either integers or floating point numbers. In PowerShell this is a double. Schema Number (http://json-schema.org/understanding-json-schema/reference/numeric.html#number) Schema Types (https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaBoolean
The boolean type matches only two special values: true and false. Note that values that evaluate to true or false, such as 1 and 0, are not accepted by the schema. Schema Boolean (http://json-schema.org/understanding-json-schema/reference/boolean.html) Schema Types (https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaObject
Objects are the mapping type in JSON. They map "keys" to "values". In JSON, the "keys" must always be strings. Each of these pairs is conventionally referred to as a "property". Schema Object (https://json-schema.org/understanding-json-schema/reference/object.html) Schema Types (https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaArray
Arrays are used for ordered elements. In JSON, each element in an array may be of a different type. Schema Array (https://json-schema.org/understanding-json-schema/reference/array.html) Schema Types (https://json-schema.org/understanding-json-schema/reference/type.html)

## NOTES

## RELATED LINKS

[Get-SchemaDocument](https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument)

[ConvertTo-SchemaElement](https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertTo-SchemaElement.md#convertto-schemaelement)

[About Classes](https://github.com/SchemaModule/PowerShell/blob/master/docs/about_Schema_Classes.md)

[JSON Schema Reference](https://json-schema.org/understanding-json-schema/reference/index.html)
