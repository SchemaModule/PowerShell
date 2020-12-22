# Changelog

All changes to this module should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## [2.0.0] - 2020-12-22

### Added

- Added classes to define JSON schema objects
- Added utility methods to classes
- Added Functions to support the classes
- New-SchemaElement
- New-SchemaString
- New-SchemaInteger
- New-SchemaNumber
- New-SchemaProperty
- Get-SchemaDefinition
- Get-SchemaReference
- Find-SchemaElement
- ConvertTo-SchemaElement
- ConvertFrom-SchemaObject
- ConvertFrom-SchemaArray
- Format-SchemaDocument
- Added support for types (schema.types.ps1xml)
- Added support for formatting (schema.format.ps1xml)

### Updated

- Get-SchemaDocument has been udpated to work with the new functions

### Removed

- Get-SchemaArray
- Get-SchemaObject
- Get-SchemaProperty

## [1.1.0] - 2020-09-11

### Added

- Updatable Help Support

## [1.0.0] - 2020-09-09

### Added

- Updated documentation and external help
- CHNAGELOG added
- psakefile added
- Added JSON logo

### Changed

- README
- Definition File updated with URLs and new version

### Fixed

- Missing some JSON data types, bool and int
- Write-Verbose acts different for arrays, so corrected the output

## [0.0.1] - 2020-09-08

### Added

- Repository Created
- Module manifest created
- Module file copied from outside repository
- Updated psd with defaultprefix and privatedata
- Added help and about help
- Converted functions to leverage the PowerShell Pipeline
- Removed New-RootDocument function
- Updated Schema param to be SchemaDocument
