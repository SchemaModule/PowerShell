# .ExternalHelp schema.xml
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
  [object]ToString() {
    return ($this |Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref)
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
  [object]toString() {
    return ($this |Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref)
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
  [object]toString() {
    return ($this |Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref)
  }
}
class schemaBoolean {
  [ValidateSet('boolean')]
  [string]$type = 'boolean'
  [string]$id
  [string]$title
  [string]$description
  [bool]$default
  [bool[]]$enum
  #
  # Methods
  #
  [object]toString() {
    return ($this |Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref)
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
  [object[]]$enum

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
  [object]Find([string]$item) {
    return (Find-SchemaElement -Schema $this -ElementName $item)
  }
  [object]toString() {
    return ($this |Select-Object *, @{Name = '$id'; Exp = { $_.id } } -ExcludeProperty id)
  }
  [object]toObject() {
    return (ConvertFrom-SchemaObject -document $this)
  }
  [object]toObject([int]$Depth) {
    return (ConvertFrom-SchemaObject -document $this -depth $Depth)
  }
  [object]toObject([string]$PropertyName) {
    [object]$retVal = New-Object object;
    if ($this.properties.Contains($PropertyName)) {
      Add-Member -InputObject $retVal -MemberType NoteProperty -Name $PropertyName -Value (ConvertFrom-SchemaObject -document ($this.GetProperty($PropertyName)))
    } else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
    return $retVal
  }
  [object]toObject([string]$PropertyName,[int]$Depth) {
    [object]$retVal = New-Object object;
    if ($this.properties.Contains($PropertyName)) {
      Add-Member -InputObject $retVal -MemberType NoteProperty -Name $PropertyName -Value (ConvertFrom-SchemaObject -document ($this.GetProperty($PropertyName)) -depth $Depth)
    } else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
    return $retVal
  }
  [object]GetProperty([string]$PropertyName) {
    if ($this.properties.Contains($PropertyName)) {
      return ($this.properties.$PropertyName)
    } else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
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
  [object]Find([string]$item) {
    return (Find-SchemaElement -Schema $this -ElementName $item)
  }
  [object]toString() {
    return ($this |Select-Object *, @{Name = '$id'; Exp = { $_.id } } -ExcludeProperty id)
  }
  [array]toArray() {
    return (ConvertFrom-SchemaArray -document $this)
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
  [object]Find([string]$item) {
    return (Find-SchemaElement -Schema $this -ElementName $item)
  }
  [object]toString() {
    return ($this |Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$schema'; Exp = { $_.schema } }, @{Name = '$definitions'; Exp = { $_.definitions } } -ExcludeProperty id,schema,definitions)
  }
  [object]toObject() {
    return (ConvertFrom-SchemaObject -document $this)
  }
  [object]toObject([int]$Depth) {
    return (ConvertFrom-SchemaObject -document $this -depth $Depth)
  }
  [object]toObject([string]$PropertyName) {
    [object]$retVal = New-Object object;
    if ($this.properties.Contains($PropertyName)) {
      Add-Member -InputObject $retVal -MemberType NoteProperty -Name $PropertyName -Value (ConvertFrom-SchemaObject -document ($this.GetProperty($PropertyName)))
    } else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
    return $retVal
  }
  [object]toObject([string]$PropertyName,[int]$Depth) {
    [object]$retVal = New-Object object;
    if ($this.properties.Contains($PropertyName)) {
      Add-Member -InputObject $retVal -MemberType NoteProperty -Name $PropertyName -Value (ConvertFrom-SchemaObject -document ($this.GetProperty($PropertyName)) -depth $Depth)
    } else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
    return $retVal
  }
  [object]GetProperty([string]$PropertyName) {
    if ($this.properties.Contains($PropertyName)) {
      return ($this.properties.$PropertyName)
    } else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
  }
}
function Get-Document {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument',
    PositionalBinding = $true)]
  [OutputType([Object])]
  param (
    [Parameter(ValueFromPipeline)]
    [string]$Path,
    [switch]$force
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
          Return (ConvertTo-SchemaElement -object (Get-Content -Path $Path | ConvertFrom-Json));
        }
        'https' {
          Write-Verbose "Incoming HTTPs path";
          Return (ConvertTo-SchemaElement -object (Invoke-WebRequest -UseBasicParsing -Uri $Path |ConvertFrom-Json));
        }
        'http' {
          Write-Verbose "Incoming HTTP path";
          Return (ConvertTo-SchemaElement -object (Invoke-WebRequest -UseBasicParsing -Uri $Path |ConvertFrom-Json));
        }
      }
    }
    catch {
      throw $_;
    }
  }
}
function Get-Definition {
  [CmdletBinding()]
  param (
    [System.Uri]$Reference
  )
  $DefinitionName = $Reference.Fragment.Substring($Reference.Fragment.LastIndexOf('/') + 1, ($Reference.Fragment.Length - $Reference.Fragment.LastIndexOf('/')) - 1)
  $Definition = Get-SchemaDocument -Path $Reference.AbsoluteUri
  return (ConvertTo-SchemaElement -object ($Definition.definitions.($DefinitionName)))
}
function Get-Reference {
  [CmdletBinding()]
  param (
    [System.Uri]$Reference
  )
  return (Get-SchemaDocument -Path $Reference.AbsoluteUri)
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
  $schemaString = New-SchemaElement -Type string
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
  $schemaInteger = New-SchemaElement -Type integer

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
  $schemaNumber = New-SchemaElement -Type number

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
function New-Property {
  [CmdletBinding()]
  param (
    [ValidateNotNullOrEmpty()]
    [string]$Name,

    [ValidateSet([schemaDocument], [schemaNumber], [schemaInteger], [schemaString], [schemaObject], [schemaArray], [schemaBoolean])]
    $Value,

    [ValidateSet('allOf', 'anyOf', 'oneOf')]
    $Array
  )
  if ($Array) {
    $Property = (New-Object -TypeName psobject -Property @{$Array = @($value) })
  } else {
    $Property = (New-Object -TypeName psobject @{$Name = $value })
  }
  return $Property
}
function New-Element {
  [CmdletBinding()]
  param (
    [ValidateSet('string', 'number', 'integer', 'object', 'boolean', 'array', 'document')]
    [string]$Type
  )

  write-verbose "Creating new schema$($type)"
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
              Find-SchemaElement -Schema ($Schema.properties.$key) -ElementName $ElementName
            }
          }
        }
        'array' {
          write-verbose "array"
          if ($Schema.items.anyOf.properties.keys -contains $ElementName) {
            return $Schema.items.anyOf.properties.$ElementName
          }
          else {
            $keys = $Schema.items.anyOf.properties.keys
            foreach ($key in $keys) {
              write-verbose $key
              Find-SchemaElement -Schema ($Schema.items.anyOf.properties.$key) -ElementName $ElementName
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
              Find-SchemaElement -Schema ($Schema.properties.$key) -ElementType $ElementType
            }
          }
          'array' {
            $keys = $Schema.items.anyOf.properties.keys
            foreach ($key in $keys) {
              write-verbose $key
              Find-SchemaElement -Schema ($Schema.items.anyOf.properties.$key) -ElementType $ElementType
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
          Find-SchemaElement -Schema ($Schema.properties.($items[0])) -ElementPath $NewPath
        }
        'array' {
          Find-SchemaElement -Schema ($Schema.items.anyof.properties.($items[0])) -ElementPath $NewPath
        }
      }
    }
  }
}
function ConvertTo-Element {
  [CmdletBinding()]
  param (
    [object]$object
  )
  write-verbose ($object |Out-String)
  switch ($object.type) {
    'string' {
      write-verbose "Creating schemaString object"
      $Result = New-SchemaElement -Type string
      foreach ($prop in $object.psobject.properties.name) {
        write-verbose $prop
        if ($prop -eq '$id') {
          $Result.id = $object.$prop
        }
        else {
          $Result.$prop = $object.$prop
        }
        write-verbose ($Result |out-String)
      }
    }
    'integer' {
      write-verbose "Creating schemaInteger object"
      $Result = New-SchemaElement -Type integer
      foreach ($prop in $object.psobject.properties.name) {
        if ($prop -eq '$id') {
          $Result.id = $object.$prop
        }
        else {
          $Result.$prop = $object.$prop
        }
      }
    }
    'number' {
      write-verbose "Creating schemaNumber object"
      $Result = New-SchemaElement -Type number
      foreach ($prop in $object.psobject.properties.name) {
        if ($prop -eq '$id') {
          $Result.id = $object.$prop
        }
        else {
          $Result.$prop = $object.$prop
        }
      }
    }
    'boolean' {
      write-verbose "Creating schemaBoolean object"
      $Result = New-SchemaElement -Type boolean
      foreach ($prop in $object.psobject.properties.name) {
        if ($prop -eq '$id') {
          $Result.id = $object.$prop
        }
        else {
          $Result.$prop = $object.$prop
        }
      }
    }
    'object' {
      if ($object.psobject.properties.name.Contains('$schema')) {
        write-verbose "Creating schemaDcoument object"
        $Result = New-SchemaElement -Type document
      } else {
        write-verbose "Creating schemaObject object"
        $Result = New-SchemaElement -Type object
      }
      foreach ($prop in $object.psobject.properties.name) {
        if ($prop -eq '$id') {
          Write-Verbose $object.$prop
          $Result.id = $object.$prop
        }
        elseif ($prop -eq 'properties') {
          foreach ($oprop in $object.properties.psobject.properties.name) {
            write-verbose $oprop
            $Result.properties += (( New-SchemaProperty -Name $oprop -Value ( ConvertTo-SchemaElement -object ($object.properties.($oprop)) ) ))
          }
        }
        elseif ($prop -eq '$schema') {
          write-verbose "Found `$schema property"
          $Result.schema = $object.$prop
        }
        else {
          $Result.$prop = $object.$prop
        }
      }
    }
    'array' {
      write-verbose "Creating schemaArray object"
      $Result = New-SchemaElement -Type array
      foreach ($prop in $object.psobject.properties.name) {
        if ($prop -eq '$id') {
          Write-Verbose $object.$prop
          $Result.id = $object.$prop
        }
        elseif ($prop -eq 'items') {
          if ($object.items.psobject.properties.name.contains('properties')){
            Write-Verbose "Found invalid nested object"
            $Result.items += (New-SchemaProperty -Array oneOf -Value (ConvertTo-SchemaElement -object $object.items))
          } else {
            foreach ($oprop in $object.items.psobject.properties.name) {
              if (!($oprop -eq '$id')) {
                write-verbose ($object.items.psobject.properties.name |out-string)
                Write-Verbose "Found valid array object"
                Write-Verbose $oprop
                $Result.items += ($object.items.$oprop.GetEnumerator() |ForEach-Object {((New-SchemaProperty -Name $oprop -Value (ConvertTo-SchemaElement -object $_) -Array $oprop))})
              }
            }
          }
        }
        else {
          $Result.$prop = $object.$prop
        }
      }
    }
    default {
      if ($object.('$ref')) {
        if ($object.('$ref').contains('definitions')) {
          $Result = Get-SchemaDefinition -Reference $object.('$ref')
        } else {
          $Result = Get-SchemaReference -Reference $object.('$ref')
        }
      }
    }
  }
  return $Result
}
function ConvertFrom-Object {
  [cmdletbinding()]
  param (
    $document,
    $depth
  )
  [object]$retVal = New-Object object;

  if ($depth -ne 1) {
    Write-Verbose "ConvertFrom-Object: Incoming: $($depth)"
    $depth = if ($depth -gt 1) { $depth -1} else {$depth}
    Write-Verbose "ConvertFrom-Object: Calculated: $($depth)"
    foreach ($item in $document.properties.keys) {
      if ($document.schema) {
        Write-Verbose "ConvertFrom-Object: Found: $($item)"
        Add-Member -InputObject $retVal -MemberType NoteProperty -Name '$schema' -Value $document.schema;
          if ($document.id) {
            Write-Verbose "ConvertFrom-Object: Found: $($item)"
            Add-Member -InputObject $retVal -MemberType NoteProperty -Name '$id' -Value $document.id -force;
          }
        }
      switch ($document.properties.$item.type) {
        'object' {
          Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value (ConvertFrom-SchemaObject -document $document.properties.$item -depth $depth)
        }
        'array' {
          Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value @(ConvertFrom-SchemaArray -document $document.properties.$item -depth $depth)
        }
        'string' {
          Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value ""
        }
        'number' {
          Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value ([decimal]0)
        }
        'integer' {
          Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value ([int]0)
        }
        'boolean' {
          Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value $false
        }
        default {
          Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value $null
        }
      }
    }
  }
  return $retVal
}
function ConvertFrom-Array {
  [cmdletbinding()]
  param (
    $document,
    $depth
  )
  [array]$retVal = @();
  if ($depth -ne 1) {
    Write-Verbose "ConvertFrom-Array: Incoming: $($depth)"
    $depth = if ($depth -gt 1) { $depth -1} else {$depth}
    Write-Verbose "ConvertFrom-Array: Calculated: $($depth)"
    foreach ($item in $document.items) {
      foreach ($key in $document.items.keys) {
        $retVal += (ConvertFrom-SchemaObject -document $item.$key -depth $depth)
      }
    }
  }
  return $retVal
}
function Format-Document([Parameter(Mandatory, ValueFromPipeline)][String] $json) {
  $indent = 0;
  ($json -Split '\n' |
    ForEach-Object {
      if ($_ -match '[\}\]]') {
        # This line contains  ] or }, decrement the indentation level
        $indent--
      }
      $line = (' ' * $indent * 2) + $_.TrimStart().Replace(':  ', ': ')
      if ($_ -match '[\{\[]') {
        # This line contains [ or {, increment the indentation level
        $indent++
      }
      if ($line.contains('"schema"')) {
          $line.Replace('"schema"', '"$schema"')
      }
      elseif ($line.contains('"definitions"')) {
          $line.Replace('"definitions"', '"$definitions"')
      }
      elseif ($line.contains('"id": ')) {
          $line.Replace('"id": "', '"$id": "')
      }
      elseif ($line.contains('"ref"')) {
          $line.Replace('"ref"', '"$ref"')
      }
      else {
        $line
      }
    }) -Join "`n"
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