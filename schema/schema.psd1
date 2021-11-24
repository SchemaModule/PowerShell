#
# Module manifest for module 'PSGet_schema'
#
# Generated by: Jeffrey Patton
#
# Generated on: 11/24/2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'schema.psm1'

# Version number of this module.
ModuleVersion = '2.0.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'b75e69d4-47bc-4ac6-b7d7-df9a36e08bbe'

# Author of this module
Author = 'Jeffrey Patton'

# Company or vendor of this module
CompanyName = 'Patton-Tech.com'

# Copyright statement for this module
Copyright = '09/09/2020 15:15:00'

# Description of the functionality provided by this module
Description = 'A PowerShell Module for working with JSON Schema documents'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = 'types\schema.types.ps1xml'

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'formats\schema.format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Get-Document', 'Get-Definition', 'ConvertTo-Definition', 
               'Get-Reference', 'New-String', 'New-Integer', 'New-Number', 'New-Boolean', 
               'New-Property', 'New-Element', 'Find-Element', 'ConvertTo-Element', 
               'ConvertFrom-Object', 'ConvertFrom-Array', 'Format-Document'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/SchemaModule/PowerShell/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/SchemaModule'

        # A URL to an icon representing this module.
        IconUri = 'https://github.com/SchemaModule/PowerShell/blob/master/logo.png?raw=true'

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/SchemaModule/AzDevOps/PowerShell/master/CHANGELOG.md'

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable
    
 } # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://raw.githubusercontent.com/SchemaModule/PowerShell/master/cabs/'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
DefaultCommandPrefix = 'Schema'

}

