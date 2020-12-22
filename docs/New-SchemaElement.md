---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaElement.md#new-schemaelement
schema: 2.0.0
---

# New-SchemaElement

## SYNOPSIS

A function to create new SchemaModule objects

## SYNTAX

```
New-SchemaElement [[-Type] <String>] [<CommonParameters>]
```

## DESCRIPTION

A function to create new SchemaModule objects

## EXAMPLES

### Example 1

```powershell
New-SchemaElement -Type object |ConvertTo-Json
{
    "type":  "object",
    "additionalProperties":  false,
    "id":  null,
    "properties":  null,
    "required":  null,
    "title":  null,
    "description":  null,
    "default":  null,
    "enum":  null
}
```

An example of usage

## PARAMETERS

### -Type

The name of the object to create (string, number, integer, object, boolean,
array, document)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: string, number, integer, object, boolean, array, document

Required: False
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

[New-SchemaString](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaString.md#new-schemastring)

[New-SchemaNumber](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaNumber.md#new-schemanumber)

[New-SchemaInteger](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaInteger.md#new-schemainteger)

[About Classes](https://github.com/SchemaModule/PowerShell/blob/master/docs/about_Schema_Classes.md)

[JSON Schema Reference](https://json-schema.org/understanding-json-schema/reference/index.html)
