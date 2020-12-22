# Schema Classes

## about_Schema_Classes

# SHORT DESCRIPTION

This module uses several custom classes in order to provide flexibility and
functionality to the module and experience as a whole.

# LONG DESCRIPTION

This module uses several custom classes in order to provide flexibility and
functionality to the module and experience as a whole. The SchemaModule classes
are derived from the JSON Schema reference pages for draft 7.0. They contain all
the attributes for each object as well as some support methods to make working
with the objects easier.

As they are PowerShell Custom Types, they can't be used directly within
PowerShell. In order to take advantage of these types in your own scripts you
may need to add a "using" statement, or leverage the New-SchemaElement function
to instantiate the objects in the PowerShell console.

## Classes

The SchemaModule classes are derived from the JSON Schema reference pages for
draft 7.0. They contain all the attributes for each object as well as some
support methods to make working with the objects easier.

### schemaDocument

This class is really a modified object that contains the $schema attribute as
well as validation on what values can be present for that attribute.
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

# EXAMPLES

```powershell
String = New-SchemaElement -Type string

$String |Get-Member


   TypeName: schemaString

Name        MemberType Definition
----        ---------- ----------
AddEnum     Method     void AddEnum(string enum)
AddExample  Method     void AddExample(string example)
Equals      Method     bool Equals(System.Object obj)
GetHashCode Method     int GetHashCode()
GetType     Method     type GetType()
ToString    Method     System.Object ToString()
default     Property   string default {get;set;}
description Property   string description {get;set;}
enum        Property   string[] enum {get;set;}
examples    Property   string[] examples {get;set;}
id          Property   string id {get;set;}
maxLength   Property   int maxLength {get;set;}
minLength   Property   int minLength {get;set;}
pattern     Property   string pattern {get;set;}
ref         Property   string ref {get;set;}
title       Property   string title {get;set;}
type        Property   string type {get;set;}


$String.AddEnum(@('cat','dog'))

$String |ConvertTo-Json
{
    "type":  "string",
    "examples":  [

                 ],
    "id":  null,
    "ref":  null,
    "minLength":  0,
    "maxLength":  0,
    "pattern":  null,
    "enum":  [
                 "cat dog"
             ],
    "title":  null,
    "description":  null,
    "default":  null
}
#
```

```
This example shows how to create an object and access one of the methods
```

```powershell
$Schema = Get-SchemaDocument -Path 'D:\TEMP\test\schema-sample.json'
$Schema |Get-Member


   TypeName: schemaDocument

Name                 MemberType Definition
----                 ---------- ----------
AddProperty          Method     System.Object AddProperty(System.Object property)
Equals               Method     bool Equals(System.Object obj)
Find                 Method     System.Object Find(string item)
GetHashCode          Method     int GetHashCode()
GetProperty          Method     System.Object GetProperty(string PropertyName)
GetType              Method     type GetType()
ToObject             Method     System.Object ToObject(), System.Object ToObject(int Depth), System.Object ToObject(string PropertyName), System.Object ToObject(string PropertyName, int Depth)
ToString             Method     System.Object ToString()
additionalProperties Property   bool additionalProperties {get;set;}
default              Property   System.Object default {get;set;}
definitions          Property   System.Object definitions {get;set;}
description          Property   string description {get;set;}
id                   Property   string id {get;set;}
properties           Property   System.Object properties {get;set;}
required             Property   string[] required {get;set;}
schema               Property   string schema {get;set;}
title                Property   string title {get;set;}
type                 Property   string type {get;set;}


$Schema.Find('printers')

$id                                                     title               description                                        default items
---                                                     -----               -----------                                        ------- -----
#/properties/contents/items/anyOf/0/properties/printers The printers schema An explanation about the purpose of this instance. {}      @{anyOf=System.Object[]}
```

```
This is another example of using methods within a created object
```

# SEE ALSO

[Project Site](https://dev.azure.com/patton-tech/SchemaModule)

[Github Repo](https://github.com/schemamodule)
