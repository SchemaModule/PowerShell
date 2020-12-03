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

# function New-sObject {
#   param (
#     [ValidateNotNullOrEmpty()]
#     [parameter(Mandatory = $true)]
#     [string]$Id,
#     [object]$Properties,
#     [string[]]$required,
#     [bool]$AdditionalProperties = $false,
#     [string]$Title,
#     [string]$Description,
#     [object]$Default
#   )
#   $obj = [jsonObject]::new()

#   foreach ($param in $PSBoundParameters.GetEnumerator()) {
#     $obj.($param.Key) = $param.Value
#   }
#   return $obj
# }
# function New-Array {
#   param (
#     [parameter(Mandatory = $true)]
#     [ValidateNotNullOrEmpty()]
#     [string]$id,
#     [object]$items,
#     [bool]$additionalItems = $false,
#     [string]$title,
#     [string]$description,
#     [array]$default
#   )
#   $obj = [jsonArray]::new()

#   foreach ($param in $PSBoundParameters.GetEnumerator()) {
#     $obj.($param.Key) = $param.Value
#   }
#   return $obj
# }
# function ConvertTo-sObject {
#   param (
#     [object]$object
#   )
#   switch ($object.type) {
#     'object' {
#       $obj = [jsonObject]::new()
#       foreach ($property in $object.psobject.properties.name) {
#         if (!($property -eq 'properties')) {
#           switch ($property) {
#             '$id' {
#               $obj.id = $object.$property
#             }
#             default {
#               $obj.$property = $object.$property
#             }
#           }
#         }
#         else {
#           foreach ($prop in $object.properties.psobject.Properties.Name) {
#             $Elements += New-Property -Name $prop -Value (Get-Element -element $object.properties.$prop)
#           }
#         }
#       }
#     }
#   }
#   $obj.properties += $Elements
#   return $obj
# }
# function ConvertTo-sArray {
#   [cmdletbinding()]
#   param (
#     [object]$object
#   )
#   switch ($object.type) {
#     'array' {
#       $obj = [jsonArray]::new()
#       foreach ($property in $object.psobject.properties.name) {
#         if (!($property -eq 'items')) {
#           #Write-Verbose $property
#           switch ($property) {
#             '$id' {
#               $obj.id = $object.$property
#             }
#             default {
#               $obj.$property = $object.$property
#             }
#           }
#         }
#         else {
#           foreach ($prop in $object.items.psobject.Properties.Name) {
#             switch ($prop) {
#               { ($_ -eq 'allOf' -or $_ -eq 'anyOf' -or $_ -eq 'oneOf') } {
#                 Write-Verbose $prop
#                 $Elements += New-Property -Name $prop -Value ($object.items.$prop | ForEach-Object { Get-Element -element $_ })
#               }
#             }
#           }
#         }
#       }
#     }
#   }
#   $obj.items += $Elements
#   return $obj
# }


class schemaString {
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
  schemaString () {}
  schemaString (
    [int]$min,
    [int]$max
  ) {
    $this.minLength = $min
    $this.maxLength = $max
  }
  schemaString (
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
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | Remove-Null | ConvertTo-Json)
  }
}
class schemaInteger {
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
  schemaInteger () {}
  schemaInteger (
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
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | Remove-Null | ConvertTo-Json)
  }
}
class schemaNumber {
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
  schemaNumber () {}
  schemaNumber (
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
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | Remove-Null | ConvertTo-Json)
  }
}
class schemaBoolean {
  [ValidateSet('boolean')]
  [string]$type = 'boolean'
  [string]$id
  [string]$title
  [string]$description
  [bool]$default
  #
  # Methods
  #
  [object]toJson() {
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | Remove-Null | ConvertTo-Json)
  }
}
class schemaObject {
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
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | Remove-Null | ConvertTo-Json)
  }
  [object]Find([string]$item) {
    return (Find-Element -Schema $this -ElementName $item)
  }
}
class schemaArray {
  [ValidateSet('array')]
  [string]$type = 'array'
  [string]$id
  [object]$items
  [bool]$additionalItems = $false
  [string]$title
  [string]$description
  [array]$default

  #
  # Methods
  #
  [object]AddItem([object]$item) {
    $this.items += $item
    return $this
  }
  [object]toJson() {
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | Remove-Null | ConvertTo-Json)
  }
  [object]Find([string]$item) {
    return (Find-Element -Schema $this -ElementName $item)
  }
}
class schemaDocument {
  [ValidateSet('object')]
  [string]$type = 'object'
  [ValidateSet('http://json-schema.org/draft-04/schema#', 'http://json-schema.org/draft-06/schema#', 'http://json-schema.org/draft-07/schema#')]
  [string]$schema = 'http://json-schema.org/draft-04/schema#'
  [object]$definitions
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
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$schema'; Exp = { $_.schema } } -ExcludeProperty id, ref | Remove-Null | ConvertTo-Json)
  }
  [object]Find([string]$item) {
    return (Find-Element -Schema $this -ElementName $item)
  }
}

function New-String {
  [CmdletBinding()]
  param (
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string]$id,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string]$ref,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [int]$minLength,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [int]$maxLength,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string]$pattern,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string[]]$enum,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string]$title,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string]$description,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string]$default,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string[]]$examples = @()
  )
  Write-Verbose "Creating schemaString object"
  $schemaString = New-Element -Type string
  Write-Verbose ($schemaString.GetType())

  foreach ($param in $PSBoundParameters.GetEnumerator()) {
    switch ($param) {
      { ($param.Key -eq 'Verbose' -or $param.Key -eq 'Debug' -or $param.Key -eq 'ErrorAction' -or $param.Key -eq 'WarningAction' -or $param.Key -eq 'InformationAction' -or $param.Key -eq 'ErrorVariable' -or $param.Key -eq 'WarningVariable' -or $param.Key -eq 'InformationVariable' -or $param.Key -eq 'OutVariable' -or $param.Key -eq 'OutBuffer' -or $param.Key -eq 'PipelineVariable') } {}
      default {
        Write-Verbose "Setting $($param.Value) on $($param.Key)"
        $schemaString.($param.Key) = $param.Value
      }
    }
  }

  return $schemaString
}
function New-Integer {
  [CmdletBinding()]
  param (
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [string]$id,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [string]$ref,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [int]$minimum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [int]$maximum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [int]$exclusiveMinimum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [int]$exclusiveMaximum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [int]$multipleOf,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [int[]]$enum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [string]$title,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [string]$description,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [int]$default,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [int[]]$examples = @()
  )
  Write-Verbose "Creating schemaInteger object"
  $schemaInteger = New-Element -Type integer

  foreach ($param in $PSBoundParameters.GetEnumerator()) {
    switch ($param) {
      { ($param.Key -eq 'Verbose' -or $param.Key -eq 'Debug' -or $param.Key -eq 'ErrorAction' -or $param.Key -eq 'WarningAction' -or $param.Key -eq 'InformationAction' -or $param.Key -eq 'ErrorVariable' -or $param.Key -eq 'WarningVariable' -or $param.Key -eq 'InformationVariable' -or $param.Key -eq 'OutVariable' -or $param.Key -eq 'OutBuffer' -or $param.Key -eq 'PipelineVariable') } {}
      default {
        Write-Verbose "Setting $($param.Value) on $($param.Key)"
        $schemaInteger.($param.Key) = $param.Value
      }
    }
  }

  return $schemaInteger
}
function New-Number {
  [CmdletBinding()]
  param (
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [string]$id,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [string]$ref,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [decimal]$minimum,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [decimal]$maximum,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [decimal]$exclusiveMinimum,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [decimal]$exclusiveMaximum,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [decimal]$multipleOf,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [string]$title,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [string]$description,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [decimal]$default,
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [decimal[]]$examples = @()
  )
  Write-Verbose "Creating schemaNumber object"
  $schemaNumber = New-Element -Type number

  foreach ($param in $PSBoundParameters.GetEnumerator()) {
    switch ($param) {
      { ($param.Key -eq 'Verbose' -or $param.Key -eq 'Debug' -or $param.Key -eq 'ErrorAction' -or $param.Key -eq 'WarningAction' -or $param.Key -eq 'InformationAction' -or $param.Key -eq 'ErrorVariable' -or $param.Key -eq 'WarningVariable' -or $param.Key -eq 'InformationVariable' -or $param.Key -eq 'OutVariable' -or $param.Key -eq 'OutBuffer' -or $param.Key -eq 'PipelineVariable') } {}
      default {
        Write-Verbose "Setting $($param.Value) on $($param.Key)"
        $schemaNumber.($param.Key) = $param.Value
      }
    }
  }

  return $schemaNumber
}
function New-sObject {
  [CmdletBinding()]
  param (
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [ValidateSet('schemaString','schemaInteger','schemaNumber')]
    [string]$type,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [string]$id,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [string]$ref,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [int]$minLength,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [int]$maxLength,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [string]$pattern,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [ValidateSet([string[]],[int[]])]
    $enum,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [string]$title,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [string]$description,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [ValidateSet([string],[int],[decimal])]
    $default,
    [parameter(Mandatory = $false, ParameterSetName = 'string')]
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [ValidateSet([string[]],[int[]],[decimal[]])]
    $examples = @(),
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [ValidateSet([int],[decimal])]
    $minimum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [ValidateSet([int],[decimal])]
    $maximum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [ValidateSet([int],[decimal])]
    $exclusiveMinimum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [ValidateSet([int],[decimal])]
    $exclusiveMaximum,
    [parameter(Mandatory = $false, ParameterSetName = 'integer')]
    [parameter(Mandatory = $false, ParameterSetName = 'number')]
    [ValidateSet([int],[decimal])]
    $multipleOf
  )
  switch ($PSCmdlet.ParameterSetName) {
    'string' {
      $schemaObject = New-Element -Type string
    }
    'integer' {
      $schemaObject = New-Element -Type integer
    }
    'number' {
      $schemaObject = New-Element -Type number
    }
  }

  foreach ($param in $PSBoundParameters.GetEnumerator()) {
    switch ($param) {
      { ($param.Key -eq 'type' -or $param.Key -eq 'Verbose' -or $param.Key -eq 'Debug' -or $param.Key -eq 'ErrorAction' -or $param.Key -eq 'WarningAction' -or $param.Key -eq 'InformationAction' -or $param.Key -eq 'ErrorVariable' -or $param.Key -eq 'WarningVariable' -or $param.Key -eq 'InformationVariable' -or $param.Key -eq 'OutVariable' -or $param.Key -eq 'OutBuffer' -or $param.Key -eq 'PipelineVariable') } {}
      default {
        Write-Verbose "Setting $($param.Value) on $($param.Key)"
        $schemaObject.($param.Key) = $param.Value
      }
    }
  }

  return $schemaObject
}
function New-Property {
  param (
    [ValidateNotNullOrEmpty()]
    [string]$Name,
    [ValidateSet([schemaNumber], [schemaInteger], [schemaString], [schemaObject], [schemaArray], [schemaBoolean])]
    $Value,
    [ValidateSet('allOf', 'anyOf', 'oneOf')]
    $Array
  )
  switch ($Array) {
    { ($_ -eq 'allOf' -or $_ -eq 'anyOf' -or $_ -eq 'oneOf') } {
      $Property = (New-Object -TypeName psobject @{$Array = @($value) })
    }
    default {
      $Property = (New-Object -TypeName psobject @{$Name = $value })
    }
  }
  return $Property
}
function New-Element {
  param (
    [ValidateSet('string', 'number', 'integer', 'object', 'boolean', 'array', 'document')]
    [string]$Type
  )

  switch ($Type) {
    'string' {
      [schemaString]::new()
    }
    'number' {
      [schemaNumber]::new()
    }
    'integer' {
      [schemaInteger]::new()
    }
    'object' {
      [schemaObject]::new()
    }
    'boolean' {
      [schemaBoolean]::new()
    }
    'array' {
      [schemaArray]::new()
    }
    'document' {
      [schemaDocument]::new()
    }
  }
}
function Get-Element {
  [cmdletbinding()]
  param (
    [object]$element,
    [switch]$PreserveId
  )

  Write-Verbose ($element | out-string)
  Write-Verbose "ElementType: $($element.type)"
  if ($element.('$schema')) {
    write-verbose "found schema object"
    $val = New-Element -Type document
  }
  else {
    switch ($element.type) {
      'string' {
        $val = New-Element -Type string
      }
      'number' {
        $val = New-Element -Type number
      }
      'integer' {
        $val = New-Element -Type integer
      }
      'object' {
        $val = New-Element -Type object
      }
      'array' {
        $val = New-Element -Type array
      }
      'boolean' {
        $val = New-Element -Type boolean
      }
    }
  }
  foreach ($prop in ($element.psobject.properties.name)) {
    Write-Verbose $prop
    switch ($prop) {
      '$id' {
        if ($PreserveId) {
          $val.id = $element.$prop
        }
      }
      '$ref' {
        if ($PreserveId) {
          $val.ref = $element.$prop
        }
      }
      '$schema' {
        $val.schema = $element.$prop
      }
      'properties' {
        foreach ($property in $element.properties.psobject.Properties.Name) {
          Write-Verbose "ObjectProperty: $($property)"
          $Elements += New-Property -Name $property -Value (Get-Element -element $element.properties.$property)
        }
        $val.properties += $Elements
      }
      'items' {
        foreach ($property in $element.items.psobject.Properties.Name) {
          switch ($property) {
            { ($_ -eq 'allOf' -or $_ -eq 'anyOf' -or $_ -eq 'oneOf') } {
              Write-Verbose "ArrayProperty: $($property)"
              $Elements += New-Property -Name $property -Value ($element.items.$property | ForEach-Object { Get-Element -element $_ })
            }
          }
        }
        $val.items += $Elements
      }
      default {
        $val.$prop = $element.$prop
      }
    }
  }
  return $val
}
function Find-Element {
  [cmdletbinding()]
  param (
    [parameter(Mandatory = $true, ParameterSetName = 'name')]
    [parameter(Mandatory = $true, ParameterSetName = 'type')]
    [parameter(Mandatory = $true, ParameterSetName = 'path')]
    $Schema,
    [parameter(Mandatory = $false, ParameterSetName = 'name')]
    $ElementName,
    [parameter(Mandatory = $false, ParameterSetName = 'type')]
    [ValidateSet('schemaString', 'schemaNumber', 'schemaInteger', 'schemaObject', 'schemaBoolean', 'schemaArray', 'schemaDocument')]
    $ElementType,
    [parameter(Mandatory = $false, ParameterSetName = 'path')]
    $ElementPath
  )
  switch ($PSCmdlet.ParameterSetName) {
    'name' {
      switch ($Schema.type) {
        'object' {
          Write-Verbose "object"
          if ($Schema.properties.keys -contains $ElementName) {
            return $Schema.properties.$ElementName
          }
          else {
            $keys = $Schema.properties.keys
            foreach ($key in $keys) {
              write-verbose $key
              Find-Element -Schema ($Schema.properties.$key) -ElementName $ElementName
            }
          }
        }
        'array' {
          write-verbose "array"
          if ($Schema.items.anyOf.properties.keys -contains $ElementName) {
            return $Schema.items.anyOf.properties.$Element
          }
          else {
            $keys = $Schema.items.anyOf.properties.keys
            foreach ($key in $keys) {
              write-verbose $key
              Find-Element -Schema ($Schema.items.anyOf.properties.$key) -ElementName $ElementName
            }
          }
        }
      }
    }
    'type' {
      if ($schema.GetType().Name -eq $ElementType) {
        return $Schema
      }
      else {
        switch ($Schema.type) {
          'object' {
            $keys = $Schema.properties.keys
            foreach ($key in $keys) {
              Find-Element -Schema ($Schema.properties.$key) -ElementType $ElementType
            }
          }
          'array' {
            $keys = $Schema.items.anyOf.properties.keys
            foreach ($key in $keys) {
              write-verbose $key
              Find-Element -Schema ($Schema.items.anyOf.properties.$key) -ElementType $ElementType
            }
          }
        }
      }
    }
    'path' {
      write-verbose "Incoming from parameter $($ElementPath)"
      [System.Collections.ArrayList]$items = $ElementPath.Split("/")
      if ($items[0] -eq "") { $items.RemoveAt(0) }
      write-verbose "Items in collection $($Items.count)"
      write-verbose "Resource $($Items[0])"
      $NewPath = ([string]::Join("/", $items[1..$items.Count]))
      write-verbose "Outgoing to parameter $($NewPath)"
      if ([string]::IsNullOrEmpty($NewPath)) {
        switch ($schema.type) {
          'object' {
            return $Schema.properties.($items[0])
          }
          'array' {
            return $Schema.items.anyOf.properties.($items[0])
          }
        }
      }
      write-verbose "Working on $($Schema.type)"
      switch ($Schema.type) {
        'object' {
          Find-Element -Schema ($Schema.properties.($items[0])) -ElementPath $NewPath
        }
        'array' {
          Find-Element -Schema ($Schema.items.anyof.properties.($items[0])) -ElementPath $NewPath
        }
      }
    }
  }
}
Function Remove-Null {
  [cmdletbinding()]
  param(
    # Object to remove null values from
    [parameter(ValueFromPipeline, Mandatory)]
    [object[]]$InputObject,
    #By default, remove empty strings (""), specify -LeaveEmptyStrings to leave them.
    [switch]$LeaveEmptyStrings
  )
  process {
    foreach ($obj in $InputObject) {
      Write-Verbose ($obj.psobject.properties.Name | out-string)
      $AllProperties = $obj.psobject.properties.Name
      $NonNulls = $AllProperties |
      where-object { $null -ne $obj.$PSItem } |
      where-object { $LeaveEmptyStrings.IsPresent -or -not [string]::IsNullOrEmpty($obj.$PSItem) }
      $obj | Select-Object -Property $NonNulls
    }
  }
}