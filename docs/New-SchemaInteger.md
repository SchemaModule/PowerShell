---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaInteger.md#new-schemainteger
schema: 2.0.0
---

# New-SchemaInteger

## SYNOPSIS

A function to create new Schema Integer object

## SYNTAX

```
New-SchemaInteger [-id <String>] [-ref <String>] [-minimum <Int32>] [-maximum <Int32>]
 [-exclusiveMinimum <Int32>] [-exclusiveMaximum <Int32>] [-multipleOf <Int32>] [-enum <Int32[]>]
 [-title <String>] [-description <String>] [-default <Int32>] [-examples <Int32[]>] [<CommonParameters>]
```

## DESCRIPTION

A function to create new Schema Integer object

## EXAMPLES

### Example 1

```powershell
New-SchemaInteger -title Width -description "The width in feet of the room"


$id         :
title       : Width
description : The width in feet of the room
default     : 0

```

A simple example of usage

## PARAMETERS

### -default

The default keyword specifies a default value for an item.

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
Type: System.Int32[]
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
Type: System.Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -exclusiveMaximum

Ranges of numbers are specified using a combination of the minimum and maximum
keywords, (or exclusiveMinimum and exclusiveMaximum for expressing exclusive
range).

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

### -exclusiveMinimum

Ranges of numbers are specified using a combination of the minimum and maximum
keywords, (or exclusiveMinimum and exclusiveMaximum for expressing exclusive
range).

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

### -maximum

Ranges of numbers are specified using a combination of the minimum and maximum
keywords, (or exclusiveMinimum and exclusiveMaximum for expressing exclusive
range).

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

### -minimum

Ranges of numbers are specified using a combination of the minimum and maximum
keywords, (or exclusiveMinimum and exclusiveMaximum for expressing exclusive
range).

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

### -multipleOf

Numbers can be restricted to a multiple of a given number, using the multipleOf
keyword.

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

### schemaInteger

The integer type is used for integral numbers. In PowerShell this is an int32

[Schema Integer](http://json-schema.org/understanding-json-schema/reference/numeric.html#integer)

[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

## NOTES

## RELATED LINKS

[New-SchemaElement](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaElement.md#new-schemaelement)

[About Classes](https://github.com/SchemaModule/PowerShell/blob/master/docs/about_Schema_Classes.md)

[JSON Schema Reference](https://json-schema.org/understanding-json-schema/reference/index.html)
