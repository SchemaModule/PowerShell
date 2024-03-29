| Latest Version | PowerShell Gallery | Build Status | Project Board | Issues | License |
|-----------------|-----------------|----------------|----------------|----------------|----------------|
| [![Latest Version](https://img.shields.io/github/v/tag/SchemaModule/PowerShell)](https://github.com/SchemaModule/PowerShell/tags) | [![Powershell Gallery](https://img.shields.io/powershellgallery/dt/schema)](https://www.powershellgallery.com/packages/schema) | [![Build Status](https://dev.azure.com/patton-tech/SchemaModule/_apis/build/status/SchemaModule.PowerShell?repoName=SchemaModule%2FPowerShell&branchName=master)](https://dev.azure.com/patton-tech/SchemaModule/_build/latest?definitionId=9&repoName=SchemaModule%2FPowerShell&branchName=master) | [![Board Status](https://dev.azure.com/patton-tech/cbaf64d2-5310-475c-8874-fb2b809e3f3b/1138b36a-5cb9-4d7d-8163-32041295538f/_apis/work/boardbadge/d9f5bd6d-43e7-45ac-a1aa-f1afc7f0cb17?columnOptions=1)](https://dev.azure.com/patton-tech/cbaf64d2-5310-475c-8874-fb2b809e3f3b/_boards/board/t/1138b36a-5cb9-4d7d-8163-32041295538f/Microsoft.RequirementCategory/) | [![GitHub issues](https://img.shields.io/github/issues/SchemaModule/PowerShell)](https://github.com/SchemaModule/PowerShell/issues) | [![GitHub license](https://img.shields.io/github/license/SchemaModule/PowerShell)](https://github.com/SchemaModule/PowerShell/blob/master/LICENSE) |
# schema Module

## Description

A PowerShell Module for working with JSON Schema documents

## schema Cmdlets

### [ConvertFrom-SchemaArray](docs/ConvertFrom-SchemaArray.md)

This function takes the schemaArray object and converts it into a PowerShell array
that can be nicely output as a JSON string.

### [ConvertFrom-SchemaObject](docs/ConvertFrom-SchemaObject.md)

This function takes the schemaObject object and converts it into a PowerShell object
that can be nicely output as a JSON string.

### [ConvertFrom-SchemaDefinition](docs/ConvertFrom-SchemaDefinition.md)

This function takes an object that has the format of a Schema Definition and
converts it into the schemaDefinition class. It can also return as either the
schemaDefinition class or a json string.

### [ConvertTo-SchemaElement](docs/ConvertTo-SchemaElement.md)

This function takes the output of ConvertFrom-Json CmdLet and converts it into
SchemaModule classes.

### [Find-SchemaElement](docs/Find-SchemaElement.md)

This function provides the ability to find objects within the JSON schema either
by Name, by Type or by a Path.

### [Format-SchemaDocument](docs/Format-SchemaDocument.md)

A simple schema linter

### [Get-SchemaDefinition](docs/Get-SchemaDefinition.md)

A function to follow the Definition keyword and return the referenced schema

### [Get-SchemaDocument](docs/Get-SchemaDocument.md)

This function will return a schemaDocument object of the input Schema.

### [Get-SchemaReference](docs/Get-SchemaReference.md)

A function to follow the ref keyword and return the referenced schema

### [New-SchemaElement](docs/New-SchemaElement.md)

A function to create new SchemaModule objects

### [New-SchemaInteger](docs/New-SchemaInteger.md)

A function to create new Schema Integer object

### [New-SchemaBoolean](docs/New-SchemaBoolean.md)

A function to create new Schema Boolean object

### [New-SchemaNumber](docs/New-SchemaNumber.md)

A function to create new Schema Number object

### [New-SchemaProperty](docs/New-SchemaProperty.md)

A Function to create either an object property or array item

### [New-SchemaString](docs/New-SchemaString.md)

A function to create new Schema String object
