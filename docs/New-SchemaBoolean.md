---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaBoolean.md#new-schemaboolean
schema: 2.0.0
---

# New-SchemaBoolean

## SYNOPSIS

A function to create new Schema Boolean object

## SYNTAX

```
New-SchemaBoolean [-id <String>] [-ref <String>] [-title <String>] [-description <String>] [-default <Boolean>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

A function to create new Schema Boolean object

## EXAMPLES

### Example 1

```powershell
New-SchemaBoolean -title ExteriorAccess -description "Does the room have an exterior door" -default $false


$id         :
title       : ExteriorAccess
description : Does the room have an exterior door
default     : False
```

A simple example of usage

## PARAMETERS

### -default

The default keyword specifies a default value for an item.

```yaml
Type: System.Boolean
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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

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

### schemaBoolean

The boolean type matches only two special values: true and false. Note that
values that evaluate to true or false, such as 1 and 0, are not accepted by
the schema.

[Schema Boolean](http://json-schema.org/understanding-json-schema/reference/boolean.html)

[Schema Types](https://json-schema.org/understanding-json-schema/reference/type.html)

## NOTES

## RELATED LINKS

[New-SchemaElement](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaElement.md#new-schemaelement)

[About Classes](https://github.com/SchemaModule/PowerShell/blob/master/docs/about_Schema_Classes.md)

[JSON Schema Reference](https://json-schema.org/understanding-json-schema/reference/index.html)
