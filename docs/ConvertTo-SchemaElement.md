---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertTo-SchemaElement.md#convertto-schemaelement
schema: 2.0.0
---

# ConvertTo-SchemaElement

## SYNOPSIS

This function takes the output of ConvertFrom-Json CmdLet and converts it into
SchemaModule classes.

## SYNTAX

```
ConvertTo-SchemaElement [-Object] <Object> [<CommonParameters>]
```

## DESCRIPTION

This function takes the output of ConvertFrom-Json CmdLet and converts it into
SchemaModule classes. The input to ConvertFrom-Json should be a proper JSON
schema file, or a file with proper JSON schema objects. It will then convert those
into one of the defined classes schemaDocument, schemaObject, schemaArray,
schemaString, schemaInteger, schemaNumber or schemaBoolean.

## EXAMPLES

### Example 1

```powershell
PS C:\> $Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'

ConvertTo-SchemaElement -Object $Schema.properties.room


$id         : #/properties/room
title       : The room schema
description : An explanation about the purpose of this instance.
default     :
```

This example shows how to use the function to convert an object into a schema
class.

### Example 2

```powershell
PS C:\> $Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'

ConvertTo-SchemaElement -Object $Schema.properties.room |fl *


type        : string
id          : #/properties/room
ref         :
minLength   : 0
maxLength   : 0
pattern     :
enum        :
title       : The room schema
description : An explanation about the purpose of this instance.
default     :
examples    : {}
```

To see the full list of properties on a class simply add an asterisk to the
Format-List CmdLet.

## PARAMETERS

### -Object

This is a JSON Schema object as defined by the json-schema.org (see related links
below). This object is then converted into a PowerShell object that can be used
like any other PowerShell object.

{
 "type": "string",
 "examples": [

 ],
 "id": "#/properties/room",
 "ref": null,
 "minLength": 0,
 "maxLength": 0,
 "pattern": null,
 "enum": null,
 "title": "The room schema",
 "description": "An explanation about the purpose of this instance.",
 "default": ""
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

The SchemaModule classes are derived from the JSON Schema reference pages for
draft 7.0. They contain all the attributes for each object as well as some
support methods to make working with the objects easier.

### schemaDocument

This class is really modified object that contains the $schema attribute as well
as validation on what values can be present for that attribute.

[Schema Object](https://json-schema.org/understanding-json-schema/reference/object.html)

[Schema Keyword](https://json-schema.org/understanding-json-schema/reference/schema.html)

[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaString

The string type is used for strings of text. It may contain Unicode characters.
[Schema String](https://json-schema.org/understanding-json-schema/reference/string.html)
[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaInteger

The integer type is used for integral numbers. In PowerShell this is an int32
[Schema Integer](http://json-schema.org/understanding-json-schema/reference/numeric.html#integer)
[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaNumber

The number type is used for any numeric type, either integers or floating point
numbers. In PowerShell this is a double.
[Schema Number](http://json-schema.org/understanding-json-schema/reference/numeric.html#number)
[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaBoolean

The boolean type matches only two special values: true and false. Note that
values that evaluate to true or false, such as 1 and 0, are not accepted by the
schema.
[Schema Boolean](http://json-schema.org/understanding-json-schema/reference/boolean.html)
[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaObject

Objects are the mapping type in JSON. They map "keys" to "values". In JSON, the
"keys" must always be strings. Each of these pairs is conventionally referred
to as a "property".
[Schema Object](https://json-schema.org/understanding-json-schema/reference/object.html)
[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

### schemaArray

Arrays are used for ordered elements. In JSON, each element in an array may be
of a different type.
[Schema Array](https://json-schema.org/understanding-json-schema/reference/array.html)
[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

## NOTES

## RELATED LINKS

[Get-SchemaDocument](https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument)

[New-SchemaProperty](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaProperty.md#new-schemaproperty)

[About Classes](https://github.com/SchemaModule/PowerShell/blob/master/docs/about_Schema_Classes.md)

[JSON Schema Reference](https://json-schema.org/understanding-json-schema/reference/index.html)
