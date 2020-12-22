---
external help file: schema-help.xml
Module Name: schema
online version: https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaProperty.md#new-schemaproperty
schema: 2.0.0
---

# New-SchemaProperty

## SYNOPSIS

A Function to create either an object property or array item

## SYNTAX

```
New-SchemaProperty [[-Name] <String>] [[-Value] <Object>] [[-Array] <Object>] [<CommonParameters>]
```

## DESCRIPTION

A Function to create either an object property or array item.

## EXAMPLES

### Example 1

```powershell
New-SchemaProperty -Name Room -Value (New-SchemaString -title Room -description "Name of the room" -enum @('Living Room','Office','Bedroom','Master Bedroom','Bathroom','Kitchen')) |ConvertTo-Json
{
 "Room": {
  "type": "string",
  "examples": [

  ],
  "id": null,
  "ref": null,
  "minLength": 0,
  "maxLength": 0,
  "pattern": null,
  "enum": [
   "Living Room",
   "Office",
   "Bedroom",
   "Master Bedroom",
   "Bathroom",
   "Kitchen"
  ],
  "title": "Room",
  "description": "Name of the room",
  "default": null
 }
}
```

Creating an object property

### Example 2

```powershell
New-SchemaProperty -Name Room -Value (New-SchemaString -title Room -description "Name of the room" -enum @('Living Room','Office','Bedroom','Master Bedroom','Bathroom','Kitchen')) -Array anyOf |ConvertTo-Json -Depth 3
{
 "anyOf": [{
  "type": "string",
  "examples": [

  ],
  "id": null,
  "ref": null,
  "minLength": 0,
  "maxLength": 0,
  "pattern": null,
  "enum": [
   "Living Room",
   "Office",
   "Bedroom",
   "Master Bedroom",
   "Bathroom",
   "Kitchen"
  ],
  "title": "Room",
  "description": "Name of the room",
  "default": null
 }]
}
```

Creating an array item

## PARAMETERS

### -Array

Choose one of the following validations

 allOf: Must be valid against all of the subschemas
 anyOf: Must be valid against any of the subschemas
 oneOf: Must be valid against exactly one of the subschemas

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:
Accepted values: allOf, anyOf, oneOf

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Name of the property created (not used for arrays)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value

A valid SchemaModule class

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:
Accepted values: schemaDocument, schemaNumber, schemaInteger, schemaString, schemaObject, schemaArray, schemaBoolean

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Collections.Hashtable

## NOTES

## RELATED LINKS

[New-SchemaProperty](https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaProperty.md#new-schemaproperty)

[JSON Combining Schemas](http://json-schema.org/understanding-json-schema/reference/combining.html#combining)
