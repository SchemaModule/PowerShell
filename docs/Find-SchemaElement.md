---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/Find-SchemaElement.md#find-schemaelement
schema: 2.0.0
---

# Find-SchemaElement

## SYNOPSIS

This function provides the ability to find objects within the JSON schema either
by Name, by Type or by a Path.

## SYNTAX

### path

```
Find-SchemaElement -Schema <Object> [-ElementPath <Object>] [<CommonParameters>]
```

### type

```
Find-SchemaElement -Schema <Object> [-ElementType <Object>] [<CommonParameters>]
```

### name

```
Find-SchemaElement -Schema <Object> [-ElementName <Object>] [<CommonParameters>]
```

## DESCRIPTION

This function provides the ability to find objects within the JSON schema either
by Name, by Type or by a Path. A search by Name allows you to simply enter the
name of the item you are looking for regardless of the underlying object type.
This could potentially return any object that matches the Name provided. A search
by Type allows you to find types within an object, this will likely always return
multiple results.

A search by Path is a little different as there is no real path per se. I borrowed
a little bit from XPath and later iterations may borrow more heavily from there
as it seems to make some sense.

[XPath](https://en.wikipedia.org/wiki/XPath)

Basically we create a path based on where we are using a '/' to progress through
objects and arrays in a fashion similar to navigating a path in a filesystem. It
can be more easily seen when a JSON schema is rendered as text. For example if
we wanted to view the Computer object within our Room schema it would look like
this.

```powershell
$Schema.properties.contents.items.anyOf.properties.computers
```

Whereas using a simple path notation it could more easily be viewed like this.

```powershell
$jPath = '/contents/computers'
```

## EXAMPLES

### Example 1

```powershell
$Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'

Find-SchemaElement -Schema $Schema -ElementName room


$id         : #/properties/room
title       : The room schema
description : An explanation about the purpose of this instance.
default     :
```

This example shows how to find an object using the name, this returns the string
object for the room.

### Example 2

```powershell
$Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'

Find-SchemaElement -Schema $Schema -ElementType schemaBoolean


$id         : #/properties/closet
title       : The closet schema
description : An explanation about the purpose of this instance.
default     : False

$id         : #/properties/exterioraccess
title       : The exterioraccess schema
description : An explanation about the purpose of this instance.
default     : False
```

This example shows how to find an object using the type, this returns the matching
types found.

### Example 3

```powershell
$Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'

$Schema.properties.contents.items.anyOf.properties.computers |fl


id          : #/properties/contents/items/anyOf/0/properties/computers
title       : The computers schema
description : An explanation about the purpose of this instance.
default     : {}
items       : @{anyOf=System.Object[]}

Find-SchemaElement -Schema $Schema -ElementPath '/contents/computers' |fl


id          : #/properties/contents/items/anyOf/0/properties/computers
title       : The computers schema
description : An explanation about the purpose of this instance.
default     : {}
items       : @{anyOf=System.Object[]}
```

This example shows the difference between expanding out a schema object to access
the resource your after vs using the simple path syntax of Find-SchemaElement.

## PARAMETERS

### -ElementName

The name of the property, object or array that we are looking for

```yaml
Type: System.String
Parameter Sets: name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ElementPath

A simple Path representation of where within the schema the object can be located
using a '/' in place of properties or items keywords.

```yaml
Type: System.String
Parameter Sets: path
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ElementType

The name of one of the defined SchemaModule classes that are used.

```yaml
Type: System.String
Parameter Sets: type
Aliases:
Accepted values: schemaString, schemaNumber, schemaInteger, schemaObject, schemaBoolean, schemaArray, schemaDocument

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Schema

The schema that we are searching through

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

[About Classes](https://github.com/SchemaModule/PowerShell/blob/master/docs/about_Schema_Classes.md)

[JSON Schema Reference](https://json-schema.org/understanding-json-schema/reference/index.html)
