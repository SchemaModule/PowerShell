---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument
schema: 2.0.0
---

# Get-SchemaDocument

## SYNOPSIS

This function will return a schemaDocument object of the input Schema.

## SYNTAX

```
Get-SchemaDocument [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION

This function will return a schemaDocument object of the input Schema.
This will help in building PowerShell objects that can be defined by a JSON schema.
This allows a script to dynamically build objects based on a well-defined JSON schema.

## EXAMPLES

### Example 1

```
PS C:\> 'https://gist.githubusercontent.com/jeffpatton1971/c2d3ee98a37766a2784ccd626b9b8ca2/raw/a112c9119cce507c2b4e115c35afc6c26f63ffc7/schema.json' |Get-SchemaDocument


$schema     : http://json-schema.org/draft-07/schema
$id         : http://example.com/root.json
type        : object
title       : The Root Schema
description : The root schema is the schema that comprises the entire JSON document.
default     :
required    : {checked, dimensions, id, name...}
properties  : @{checked=; dimensions=; id=; name=; price=; tags=}
```

This example demonstrates passing a URL along the pipeline to the function.

### Example 2

```
PS C:\> Get-SchemaDocument -Path D:\CODE\JSON\schema.json


$schema     : http://json-schema.org/draft-07/schema
$id         : http://example.com/root.json
type        : object
title       : The Root Schema
description : The root schema is the schema that comprises the entire JSON document.
default     :
required    : {checked, dimensions, id, name...}
properties  : @{checked=; dimensions=; id=; name=; price=; tags=}
```

This example passes a json schema file into the function.

## PARAMETERS

### -Path

This can be a filepath or URL, the function does light validation on the input.

```yaml
Type: System.String
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

### System.String

A local or remote Json Schema file as defined by json-schema.org

## OUTPUTS

### schemaDocument

This class is really modified object that contains the $schema attribute as well
as validation on what values can be present for that attribute.

[Schema Object](https://json-schema.org/understanding-json-schema/reference/object.html)

[Schema Keyword](https://json-schema.org/understanding-json-schema/reference/schema.html)

[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

## NOTES

## RELATED LINKS

[ConvertTo-SchemaElement](https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertTo-SchemaElement.md#convertto-schemaelement)

[About Classes](https://github.com/SchemaModule/PowerShell/blob/master/docs/about_Schema_Classes.md)

[Schema Keyword](https://json-schema.org/understanding-json-schema/reference/schema.html)
