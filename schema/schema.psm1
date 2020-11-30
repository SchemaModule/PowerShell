# .ExternalHelp schema.xml
function Get-Document {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument',
    PositionalBinding = $true)]
  [OutputType([Object])]
  param (
    [Parameter(ValueFromPipeline)]
    [string]$Path
  )

  process {
    Write-Verbose $Path;
    try {
      Write-Verbose "Clearing Error Variables";
      $ErrorActionPreference = 'Stop';
      $Error.Clear();

      Write-Verbose "Parsing Path param";
      $Schema = [System.UriBuilder]::new($Path);
      Write-Verbose $Schema;

      switch ($Schema.Scheme) {
        'file' {
          Write-Verbose "Incoming Filepath";
          Return Get-Content -Path $Path | ConvertFrom-Json;
        }
        'https' {
          Write-Verbose "Incoming HTTPs path";
          $Response = Invoke-WebRequest -UseBasicParsing -Uri $Path;
        }
        'http' {
          Write-Verbose "Incoming HTTP path";
          $Response = Invoke-WebRequest -UseBasicParsing -Uri $Path;
        }
      }
      if ($Response.Content.GetType().Name -eq 'Byte[]') {
        [string]::new($Response.Content) | ConvertFrom-Json;
      }
      else {
        $Response.Content | ConvertFrom-Json
      }
    }
    catch {
      throw $_;
    }
  }
}
function Get-Object {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-Object.md#get-object',
    PositionalBinding = $true)]
  [OutputType([Object])]
  param (
    [Parameter(ValueFromPipeline)]
    [object]$SchemaDocument
  )

  process {
    Write-Verbose ($SchemaDocument | Out-String);
    $Properties = $SchemaDocument.properties | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name;
    Write-Verbose "Setting up output object";
    $Members = @{};
    foreach ($Property in $Properties) {
      Write-Verbose "Property: $($Property)";
      switch ($SchemaDocument.properties.$Property.type) {
        'object' {
          Write-Verbose "Add Object to output object";
          $Members.Add($Property, (New-Object -TypeName psobject -Property @{}))
        }
        'array' {
          Write-Verbose "Add Array to output object";
          $Members.Add($Property, @())
        }
        'string' {
          Write-Verbose "Add String to output object";
          $Members.Add($Property, "")
        }
        'number' {
          Write-Verbose "Add Number to output object";
          $Members.Add($Property, [int])
        }
        'integer' {
          Write-Verbose "Add Integer to output object";
          $Members.Add($Property, [decimal])
        }
        'boolean' {
          Write-Verbose "Add Boolean to output object";
          $Members.Add($Property, [bool])
        }
      }
    }
    Write-Verbose "Return JSON PowerShell object";
    New-Object -TypeName psobject -Property $Members;
  }
}
function Get-Array {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-Array.md#get-array',
    PositionalBinding = $true)]
  [OutputType([Array])]
  param (
    [Parameter(ValueFromPipeline)]
    [object]$SchemaDocument
  )

  process {
    Write-Verbose ($SchemaDocument | Out-String);
    $Properties = $SchemaDocument.items.anyOf.properties | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name;
    Write-Verbose "Setting up output object";
    $Members = @{};
    foreach ($Property in $Properties) {
      Write-Verbose "Property: $($Property)";
      switch ($SchemaDocument.items.anyOf.properties.$Property.type) {
        'object' {
          Write-Verbose "Add Object to output object";
          $Members.Add($Property, (New-Object -TypeName psobject -Property @{}))
        }
        'array' {
          Write-Verbose "Add Array to output object";
          $Members.Add($Property, @())
        }
        'string' {
          Write-Verbose "Add String to output object";
          $Members.Add($Property, "")
        }
        'number' {
          Write-Verbose "Add Number to output object";
          $Members.Add($Property, [int])
        }
        'integer' {
          Write-Verbose "Add Integer to output object";
          $Members.Add($Property, [decimal])
        }
        'boolean' {
          Write-Verbose "Add Boolean to output object";
          $Members.Add($Property, [bool])
        }
      }
    }
    Write-Verbose "Return JSON PowerShell object";
    New-Object -TypeName psobject -Property $Members;
  }
}
function Get-Property {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-Property.md#get-property',
    PositionalBinding = $true)]
  [OutputType([Object])]
  param (
    [Parameter(ValueFromPipeline)]
    [object]$SchemaDocument,
    [string]$Name
  )

  process {
    Write-Verbose ($SchemaDocument | Out-String);
    Write-Verbose $Name;
    if ($Name) {
      Write-Verbose "Return specific Property";
      $SchemaDocument.properties.$Name;
    }
    else {
      Write-Verbose "Return all properties";
      $SchemaDocument.properties;
    }
  }
}

class jsonString {
  [ValidateSet('string')]
  [string]$type = 'string'
  [string]$id
  [string]$ref
  [int]$minLength
  [int]$maxLength
  [string]$pattern
  [string[]]$enum
  [string]$title
  [string]$description
  [string]$default
  [string[]]$examples = @()

  #
  # Constructors
  #
  jsonString () {}
  jsonString (
    [int]$min,
    [int]$max
  ) {
    $this.minLength = $min
    $this.maxLength = $max
  }
  jsonString (
    [string]$reg
  ) {
    $this.pattern = $reg
  }

  #
  # Methods
  #
  [void]AddExample([string]$example) {
    $this.examples += $example
  }
  [void]AddEnum([string]$enum) {
    $this.enum += $enum
  }
  [object]toJson() {
    return ($this |Remove-Null |ConvertTo-Json)
  }
}
class jsonInteger {
  [ValidateSet('integer')]
  [string]$type = 'integer'
  [string]$id
  [string]$ref
  [int]$minimum
  [int]$maximum
  [int]$exclusiveMinimum
  [int]$exclusiveMaximum
  [int]$multipleOf
  [int[]]$enum
  [string]$title
  [string]$description
  [int]$default
  [int[]]$examples = @()

  #
  # Constructors
  #
  jsonInteger () {}
  jsonInteger (
    [int]$min,
    [int]$max
  ) {
    $this.minimum = $min
    $this.maximum = $max
  }

  #
  # Methods
  #
  [void]AddExample([int]$example) {
    $this.examples += $example
  }
  [void]AddEnum([int]$enum) {
    $this.enum += $enum
  }
  [object]toJson() {
    return ($this |Remove-Null |ConvertTo-Json)
  }
}
class jsonNumber {
  [ValidateSet('number')]
  [string]$type = 'number'
  [string]$id
  [string]$ref
  [decimal]$minimum
  [decimal]$maximum
  [decimal]$exclusiveMinimum
  [decimal]$exclusiveMaximum
  [decimal]$multipleOf
  [string]$title
  [string]$description
  [decimal]$default
  [decimal[]]$examples = @()

  #
  # Constructors
  #
  jsonNumber () {}
  jsonNumber (
    [decimal]$min,
    [decimal]$max
  ) {
    $this.minimum = $min
    $this.maximum = $max
  }

  #
  # Methods
  #
  [void]AddExample([decimal]$example) {
    $this.examples += $example
  }
  [object]toJson() {
    return ($this |Remove-Null |ConvertTo-Json)
  }
}
class jsonObject {
  [ValidateSet('object')]
  [string]$type = 'object'
  [string]$id
  [object]$properties
  [string[]]$required
  [bool]$additionalProperties = $false
  [string]$title
  [string]$description
  [object]$default

  #
  # Constructors
  #

  #
  # Methods
  #
  [object]AddProperty([object]$property) {
    $this.properties += $property
    return $this
  }
  [object]toJson() {
    return ($this |ConvertTo-Json)
  }
}
function New-sObject {
  param (
    [ValidateNotNullOrEmpty()]
    [parameter(Mandatory=$true)]
    [string]$Id,
    [object]$Properties,
    [string[]]$required,
    [bool]$AdditionalProperties = $false,
    [string]$Title,
    [string]$Description,
    [object]$Default
  )
  $obj = [jsonObject]::new()
  $obj.id = $Id
  $obj.properties = $Properties
  $obj.required = $required
  $obj.additionalProperties = $AdditionalProperties
  $obj.title = $Title
  $obj.description = $Description
  $obj.default = $Default

  return $obj
}
function ConvertTo-sObject {
  param (
    [object]$object
  )
  switch ($object.type) {
    'object' {
      $obj = [jsonObject]::new()
      foreach ($property in $object.psobject.properties.name) {
        if (!($property -eq 'properties')) {
          switch ($property) {
            '$id' {
              $obj.id = $object.$property
            }
            default {
              $obj.$property = $object.$property
            }
          }
        } else {
          foreach ($prop in $object.properties.psobject.Properties.Name) {
            $Elements += New-Property -Name $prop -Value (Get-Element -element $object.properties.$prop)
          }
        }
      }
    }
  }
  $obj.properties += $Elements
  return $obj
}
function New-Property {
  param (
    [ValidateNotNullOrEmpty()]
    [string]$Name,
    [ValidateSet([jsonNumber],[jsonInteger],[jsonString])]
    $Value
  )
  return (New-Object -TypeName psobject @{$Name=$value})
}
function New-Element {
  param (
    [ValidateSet('string', 'number', 'integer')]
    [string]$Type
  )

  switch ($Type) {
    'string' {
      [jsonString]::new()
    }
    'number' {
      [jsonNumber]::new()
    }
    'integer' {
      [jsonInteger]::new()
    }
  }
}
function Get-Element {
  param (
    [object]$element,
    [switch]$PreserveId
  )

  switch ($element.type) {
    'string' {
      $val = [jsonString]::new()
    }
    'number' {
      $val = [jsonNumber]::new()
    }
    'integer' {
      $val = [jsonInteger]::new()
    }
  }
  foreach ($prop in ($element.psobject.properties.name)) {
    switch ($prop) {
      '$id' {
        if ($PreserveId) {
          $val.id = $element.$prop
        }
      }
      default {
        $val.$prop = $element.$prop
      }
    }
  }
  return $val
}
Function Remove-Null {
  [cmdletbinding()]
  param(
      # Object to remove null values from
      [parameter(ValueFromPipeline,Mandatory)]
      [object[]]$InputObject,
      #By default, remove empty strings (""), specify -LeaveEmptyStrings to leave them.
      [switch]$LeaveEmptyStrings
  )
  process {
      foreach ($obj in $InputObject) {
        Write-Verbose ($obj.psobject.properties.Name |out-string)
          $AllProperties = $obj.psobject.properties.Name
          $NonNulls = $AllProperties |
              where-object {$null -ne $obj.$PSItem} |
              where-object {$LeaveEmptyStrings.IsPresent -or -not [string]::IsNullOrEmpty($obj.$PSItem)}
          $obj | Select-Object -Property $NonNulls
      }
  }
}