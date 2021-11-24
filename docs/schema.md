---
Module Name: schema
Module Guid: b75e69d4-47bc-4ac6-b7d7-df9a36e08bbe
Download Help Link: https://raw.githubusercontent.com/SchemaModule/PowerShell/master/cabs/
Help Version: 2.0.0
Locale: en-US
---

# schema Module

## Description

A PowerShell Module for working with JSON Schema documents

## schema Cmdlets

### [ConvertFrom-SchemaArray](ConvertFrom-SchemaArray.md)

This function takes the schemaArray object and converts it into a PowerShell array
that can be nicely output as a JSON string.

### [ConvertFrom-SchemaObject](ConvertFrom-SchemaObject.md)

This function takes the schemaObject object and converts it into a PowerShell object
that can be nicely output as a JSON string.

### [ConvertFrom-SchemaDefinition](ConvertFrom-SchemaDefinition.md)

This function takes an object that has the format of a Schema Definition and
converts it into the schemaDefinition class. It can also return as either the
schemaDefinition class or a json string.

### [ConvertTo-SchemaElement](ConvertTo-SchemaElement.md)

This function takes the output of ConvertFrom-Json CmdLet and converts it into
SchemaModule classes.

### [Find-SchemaElement](Find-SchemaElement.md)

This function provides the ability to find objects within the JSON schema either
by Name, by Type or by a Path.

### [Format-SchemaDocument](Format-SchemaDocument.md)

A simple schema linter

### [Get-SchemaDefinition](Get-SchemaDefinition.md)

A function to follow the Definition keyword and return the referenced schema

### [Get-SchemaDocument](Get-SchemaDocument.md)

This function will return a schemaDocument object of the input Schema.

### [Get-SchemaReference](Get-SchemaReference.md)

A function to follow the ref keyword and return the referenced schema

### [New-SchemaElement](New-SchemaElement.md)

A function to create new SchemaModule objects

### [New-SchemaInteger](New-SchemaInteger.md)

A function to create new Schema Integer object

### [New-SchemaBoolean](New-SchemaBoolean.md)

A function to create new Schema Boolean object

### [New-SchemaNumber](New-SchemaNumber.md)

A function to create new Schema Number object

### [New-SchemaProperty](New-SchemaProperty.md)

A Function to create either an object property or array item

### [New-SchemaString](New-SchemaString.md)

A function to create new Schema String object
