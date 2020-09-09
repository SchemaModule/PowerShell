---
external help file: schema-help.xml
Module Name: schema
online version:
schema: 2.0.0
---

# Get-SchemaProperty

## SYNOPSIS
This function returns one ore more properties from a Json Schema object.

## SYNTAX

```
Get-SchemaProperty [[-SchemaDocument] <Object>] [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function returns one ore more properties from a Json Schema object. This will allow you to view the detailed
information of a given property from the Schema.

## EXAMPLES

### Example 1
```powershell
PS C:\> $SchemaDocument.properties.products.items.anyOf |Get-SchemaProperty


checked    : @{$id=#/properties/products/items/anyOf/0/properties/checked; type=boolean; title=The checked schema; description=An explanation about the purpose of this instance.; default=False; examples=System.Object[]}
dimensions : @{$id=#/properties/products/items/anyOf/0/properties/dimensions; type=object; title=The dimensions schema; description=An explanation about the purpose of this instance.; default=; examples=System.Object[]; required=System.Object[]; properties=;
             additionalProperties=True}
id         : @{$id=#/properties/products/items/anyOf/0/properties/id; type=integer; title=The id schema; description=An explanation about the purpose of this instance.; default=0; examples=System.Object[]}
name       : @{$id=#/properties/products/items/anyOf/0/properties/name; type=string; title=The name schema; description=An explanation about the purpose of this instance.; default=; examples=System.Object[]}
price      : @{$id=#/properties/products/items/anyOf/0/properties/price; type=number; title=The price schema; description=An explanation about the purpose of this instance.; default=0.0; examples=System.Object[]}
tags       : @{$id=#/properties/products/items/anyOf/0/properties/tags; type=array; title=The tags schema; description=An explanation about the purpose of this instance.; default=System.Object[]; examples=System.Object[]; additionalItems=True; items=}
```

This example passes the schema object along the pipeline and returns all properties.

### Example 2
```powershell
PS C:\> Get-SchemaProperty -SchemaDocument $SchemaDocument.properties.products.items.anyOf -Name dimensions


$id                  : #/properties/products/items/anyOf/0/properties/dimensions
type                 : object
title                : The dimensions schema
description          : An explanation about the purpose of this instance.
default              :
examples             : {@{width=5; height=10}}
required             : {width, height}
properties           : @{width=; height=}
additionalProperties : True
```

This example passes the Schema into the function and references a specific named property to return.

## PARAMETERS

### -Name
The name of a property to return

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SchemaDocument
This should be the output of Get-SchemaDocument. For simple JSON schema's this could be passed along the pipeline
to this function.

```yaml
Type: Object
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
### System.Object
This should always be the output of the Get-SchemaDocument function.

## OUTPUTS
### System.Object
A PowerShell representation of the referenced schema

## NOTES

## RELATED LINKS
[Get-SchemaDocument](https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument)