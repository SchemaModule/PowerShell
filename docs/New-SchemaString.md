---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaString.md#new-schemastring
schema: 2.0.0
---

# New-SchemaString

## SYNOPSIS

A function to create new Schema String object

## SYNTAX

```
New-SchemaString [-id <String>] [-ref <String>] [-minLength <Int32>] [-maxLength <Int32>] [-pattern <String>]
 [-enum <String[]>] [-title <String>] [-description <String>] [-default <String>] [-examples <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

id          :
ref         :
minLength   : 0
maxLength   : 0
pattern     :
enum        : {Living Room, Office, Bedroom, Master Bedroom...}
title       : Room
description : Name of the room
default     :
examples    : {}

```

A simple example of usage

## PARAMETERS

### -default
The default keyword specifies a default value for an item.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description

The title and description keywords must be strings. A "description" will provide

a more lengthy explanation about the purpose of the data described by the schema

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -enum

The enum keyword is used to restrict a value to a fixed set of values. It must
be an array with at least one element, where each element is unique.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -examples

The examples keyword is a place to provide an array of examples that validate
against the schema.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id

The $id property is a URI-reference that serves two purposes, it declares a
unique identifier for the schema and it declares a base URI against which $ref
URI-references are resolved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -maxLength

The length of a string can be constrained using the minLength and maxLength
keywords. For both keywords, the value must be a non-negative number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -minLength

The length of a string can be constrained using the minLength and maxLength
keywords. For both keywords, the value must be a non-negative number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pattern

The pattern keyword is used to restrict a string to a particular regular
expression. The regular expression syntax is the one defined in JavaScript
(ECMA 262 specifically)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ref

The $id property is a URI-reference that serves two purposes, it declares a
unique identifier for the schema and it declares a base URI against which $ref
URI-references are resolved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -title

The title and description keywords must be strings. A "title" will preferably be
short explanation about the purpose of the data described by the schema.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
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

### schemaString

The string type is used for strings of text. It may contain Unicode characters.
[Schema String](https://json-schema.org/understanding-json-schema/reference/string.html)
[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

## NOTES

## RELATED LINKS

[New-SchemaString](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaString.md#new-schemastring)

[JSON Schema Reference](https://json-schema.org/understanding-json-schema/reference/index.html)
