# Schema Classes

## about_Schema_Classes

```
ABOUT TOPIC NOTE:
The first header of the about topic should be the topic name.
The second header contains the lookup name used by the help system.

IE:
# Some Help Topic Name
## SomeHelpTopicFileName

This will be transformed into the text file
as `about_SomeHelpTopicFileName`.
Do not include file extensions.
The second header should have no spaces.
```

# SHORT DESCRIPTION

This module uses several custom classes in order to provide flexibility and
functionality to the module and experience as a whole.

```
ABOUT TOPIC NOTE:
About topics can be no longer than 80 characters wide when rendered to text.
Any topics greater than 80 characters will be automatically wrapped.
The generated about topic will be encoded UTF-8.
```

# LONG DESCRIPTION

{{ Long Description Placeholder }}

## Classes

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

# EXAMPLES

{{ Code or descriptive examples of how to leverage the functions described. }}

# NOTE

{{ Note Placeholder - Additional information that a user needs to know.}}

# TROUBLESHOOTING NOTE

{{ Troubleshooting Placeholder - Warns users of bugs}}

{{ Explains behavior that is likely to change with fixes }}

# SEE ALSO

{{ See also placeholder }}

{{ You can also list related articles, blogs, and video URLs. }}

# KEYWORDS

{{List alternate names or titles for this topic that readers might use.}}

- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
