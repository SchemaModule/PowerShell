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
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | ConvertTo-Json)
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
  [object]ToString() {
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | ConvertTo-Json)
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
  [object]ToString() {
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | ConvertTo-Json)
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
  [object]ToString() {
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$ref'; Exp = { $_.ref } } -ExcludeProperty id, ref | ConvertTo-Json)
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
  [object]ToString() {
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } } -ExcludeProperty id | ConvertTo-Json)
  }
  [object]ToObject() {
    return (ConvertFrom-SchemaObject -Object $this)
  }
  [object]ToObject([int]$Depth) {
    return (ConvertFrom-SchemaObject -Object $this -depth $Depth)
  }
  [object]ToObject([string]$PropertyName) {
    [object]$retVal = New-Object object;
    if ($this.properties.Contains($PropertyName)) {
      Add-Member -InputObject $retVal -MemberType NoteProperty -Name $PropertyName -Value (ConvertFrom-SchemaObject -Object ($this.GetProperty($PropertyName)))
    }
    else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
    return $retVal
  }
  [object]ToObject([string]$PropertyName, [int]$Depth) {
    [object]$retVal = New-Object object;
    if ($this.properties.Contains($PropertyName)) {
      Add-Member -InputObject $retVal -MemberType NoteProperty -Name $PropertyName -Value (ConvertFrom-SchemaObject -Object ($this.GetProperty($PropertyName)) -depth $Depth)
    }
    else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
    return $retVal
  }
  [object]GetProperty([string]$PropertyName) {
    if ($this.properties.Contains($PropertyName)) {
      return ($this.properties.$PropertyName)
    }
    else {
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
  [object]ToString() {
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } } -ExcludeProperty id | ConvertTo-Json)
  }
  [array]ToArray() {
    return (ConvertFrom-SchemaArray -Array $this)
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
  [object]ToString() {
    return ($this | Select-Object *, @{Name = '$id'; Exp = { $_.id } }, @{Name = '$schema'; Exp = { $_.schema } }, @{Name = '$definitions'; Exp = { $_.definitions } } -ExcludeProperty id, schema, definitions | ConvertTo-Json)
  }
  [object]ToObject() {
    return (ConvertFrom-SchemaObject -Object $this)
  }
  [object]ToObject([int]$Depth) {
    return (ConvertFrom-SchemaObject -Object $this -depth $Depth)
  }
  [object]ToObject([string]$PropertyName) {
    [object]$retVal = New-Object object;
    if ($this.properties.Contains($PropertyName)) {
      Add-Member -InputObject $retVal -MemberType NoteProperty -Name $PropertyName -Value (ConvertFrom-SchemaObject -Object ($this.GetProperty($PropertyName)))
    }
    else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
    return $retVal
  }
  [object]ToObject([string]$PropertyName, [int]$Depth) {
    [object]$retVal = New-Object object;
    if ($this.properties.Contains($PropertyName)) {
      Add-Member -InputObject $retVal -MemberType NoteProperty -Name $PropertyName -Value (ConvertFrom-SchemaObject -Object ($this.GetProperty($PropertyName)) -depth $Depth)
    }
    else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
    return $retVal
  }
  [object]GetProperty([string]$PropertyName) {
    if ($this.properties.Contains($PropertyName)) {
      return ($this.properties.$PropertyName)
    }
    else {
      throw "$($PropertyName) not found in collection $($this.properties.keys |Out-String)"
    }
  }
}
function Get-Document {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDocument.md#get-schemadocument',
    PositionalBinding = $true)]
  [OutputType([schemaDocument])]
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
          Return (ConvertTo-SchemaElement -object (Get-Content -Path $Path | ConvertFrom-Json));
        }
        'https' {
          Write-Verbose "Incoming HTTPs path";
          Return (ConvertTo-SchemaElement -object (Invoke-WebRequest -UseBasicParsing -Uri $Path | ConvertFrom-Json));
        }
        'http' {
          Write-Verbose "Incoming HTTP path";
          Return (ConvertTo-SchemaElement -object (Invoke-WebRequest -UseBasicParsing -Uri $Path | ConvertFrom-Json));
        }
      }
    }
    catch {
      throw $_;
    }
  }
}
function Get-Definition {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaDefinition.md#get-schemadefinition',
    PositionalBinding = $true)]
  [OutputType([schemaDocument], [schemaString], [schemaInteger], [schemaNumber], [schemaBoolean], [schemaObject], [schemaArray])]
  param (
    [Parameter(ValueFromPipeline)]
    [System.Uri]$Reference
  )
  process {
    $DefinitionName = $Reference.Fragment.Substring($Reference.Fragment.LastIndexOf('/') + 1, ($Reference.Fragment.Length - $Reference.Fragment.LastIndexOf('/')) - 1)
    $Definition = Get-SchemaDocument -Path $Reference.AbsoluteUri
    return (ConvertTo-SchemaElement -object ($Definition.definitions.($DefinitionName)))
  }
}
function Get-Reference {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Get-SchemaReference.md#get-schemareference',
    PositionalBinding = $true)]
  [OutputType([schemaDocument], [schemaString], [schemaInteger], [schemaNumber], [schemaBoolean], [schemaObject], [schemaArray])]
  param (
    [Parameter(ValueFromPipeline)]
    [System.Uri]$Reference
  )
  process {
    return (Get-SchemaDocument -Path $Reference.AbsoluteUri)
  }
}
function New-String {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaString.md#new-schemastring',
    PositionalBinding = $true)]
  [OutputType([schemaString])]
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
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaInteger.md#new-schemainteger',
    PositionalBinding = $true)]
  [OutputType([schemaInteger])]
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
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaNumber.md#new-schemanumber',
    PositionalBinding = $true)]
  [OutputType([schemaNumber])]
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
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaProperty.md#new-schemaproperty',
    PositionalBinding = $true)]
  [OutputType([hashtable])]
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
  }
  else {
    $Property = (New-Object -TypeName psobject @{$Name = $value })
  }
  return $Property
}
function New-Element {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/New-SchemaElement.md#new-schemaelement',
    PositionalBinding = $true)]
  [OutputType([schemaDocument], [schemaString], [schemaInteger], [schemaNumber], [schemaBoolean], [schemaObject], [schemaArray])]
  param (
    [ValidateSet('string', 'number', 'integer', 'object', 'boolean', 'array', 'document')]
    [string]$Type
  )

  write-verbose "Creating new schema$($Type)"
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
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Find-SchemaElement.md#find-schemaelement',
    PositionalBinding = $true)]
  [OutputType([schemaDocument], [schemaString], [schemaInteger], [schemaNumber], [schemaBoolean], [schemaObject], [schemaArray])]
  param (
    [parameter(Mandatory = $true, ParameterSetName = 'name')]
    [parameter(Mandatory = $true, ParameterSetName = 'type')]
    [parameter(Mandatory = $true, ParameterSetName = 'path')]
    $Schema,
    [parameter(Mandatory = $false, ParameterSetName = 'name')]
    [string]$ElementName,
    [parameter(Mandatory = $false, ParameterSetName = 'type')]
    [ValidateSet('schemaString', 'schemaNumber', 'schemaInteger', 'schemaObject', 'schemaBoolean', 'schemaArray', 'schemaDocument')]
    [string]$ElementType,
    [parameter(Mandatory = $false, ParameterSetName = 'path')]
    [string]$ElementPath
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
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertTo-SchemaElement.md#convertto-schemaelement',
    PositionalBinding = $true)]
  [OutputType([schemaDocument], [schemaString], [schemaInteger], [schemaNumber], [schemaBoolean], [schemaObject], [schemaArray])]
  param (
    [parameter(Mandatory = $true, Position = 0)]
    [object]$Object
  )
  write-verbose ($Object | Out-String)
  switch ($Object.type) {
    'string' {
      write-verbose "Creating schemaString object"
      $Result = New-SchemaElement -Type string
      foreach ($prop in $Object.psobject.properties.name) {
        write-verbose $prop
        if ($prop -eq '$id') {
          $Result.id = $Object.$prop
        }
        else {
          $Result.$prop = $Object.$prop
        }
        write-verbose ($Result | out-String)
      }
    }
    'integer' {
      write-verbose "Creating schemaInteger object"
      $Result = New-SchemaElement -Type integer
      foreach ($prop in $Object.psobject.properties.name) {
        if ($prop -eq '$id') {
          $Result.id = $Object.$prop
        }
        else {
          $Result.$prop = $Object.$prop
        }
      }
    }
    'number' {
      write-verbose "Creating schemaNumber object"
      $Result = New-SchemaElement -Type number
      foreach ($prop in $Object.psobject.properties.name) {
        if ($prop -eq '$id') {
          $Result.id = $Object.$prop
        }
        else {
          $Result.$prop = $Object.$prop
        }
      }
    }
    'boolean' {
      write-verbose "Creating schemaBoolean object"
      $Result = New-SchemaElement -Type boolean
      foreach ($prop in $Object.psobject.properties.name) {
        if ($prop -eq '$id') {
          $Result.id = $Object.$prop
        }
        else {
          $Result.$prop = $Object.$prop
        }
      }
    }
    'object' {
      if ($Object.psobject.properties.name.Contains('$schema')) {
        write-verbose "Creating schemaDcoument object"
        $Result = New-SchemaElement -Type document
      }
      else {
        write-verbose "Creating schemaObject object"
        $Result = New-SchemaElement -Type object
      }
      foreach ($prop in $Object.psobject.properties.name) {
        if ($prop -eq '$id') {
          Write-Verbose $Object.$prop
          $Result.id = $Object.$prop
        }
        elseif ($prop -eq 'properties') {
          foreach ($oprop in $Object.properties.psobject.properties.name) {
            write-verbose $oprop
            $Result.properties += (( New-SchemaProperty -Name $oprop -Value ( ConvertTo-SchemaElement -object ($Object.properties.($oprop)) ) ))
          }
        }
        elseif ($prop -eq '$schema') {
          write-verbose "Found `$schema property"
          $Result.schema = $Object.$prop
        }
        else {
          $Result.$prop = $Object.$prop
        }
      }
    }
    'array' {
      write-verbose "Creating schemaArray object"
      $Result = New-SchemaElement -Type array
      foreach ($prop in $Object.psobject.properties.name) {
        if ($prop -eq '$id') {
          Write-Verbose $Object.$prop
          $Result.id = $Object.$prop
        }
        elseif ($prop -eq 'items') {
          if ($Object.items.psobject.properties.name.contains('properties')) {
            Write-Verbose "Found invalid nested object"
            $Result.items += (New-SchemaProperty -Array oneOf -Value (ConvertTo-SchemaElement -object $Object.items))
          }
          else {
            foreach ($oprop in $Object.items.psobject.properties.name) {
              if (!($oprop -eq '$id')) {
                write-verbose ($Object.items.psobject.properties.name | out-string)
                Write-Verbose "Found valid array object"
                Write-Verbose $oprop
                $Result.items += ($Object.items.$oprop.GetEnumerator() | ForEach-Object { ((New-SchemaProperty -Name $oprop -Value (ConvertTo-SchemaElement -object $_) -Array $oprop)) })
              }
            }
          }
        }
        else {
          $Result.$prop = $Object.$prop
        }
      }
    }
    default {
      if ($Object.('$ref')) {
        if ($Object.('$ref').contains('definitions')) {
          $Result = Get-SchemaDefinition -Reference $Object.('$ref')
        }
        else {
          $Result = Get-SchemaReference -Reference $Object.('$ref')
        }
      }
    }
  }
  return $Result
}
function ConvertFrom-Object {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertFrom-SchemaObject.md#convertfrom-schemaobject',
    PositionalBinding = $true)]
  [OutputType([object])]
  param (
    [parameter(Mandatory = $true, Position = 0)]
    $Object,
    [parameter(Mandatory = $false, Position = 1)]
    [int]$Depth
  )
  if ($Object.type -eq 'object') {
    [object]$retVal = New-Object object;
    if ($Depth -ne 1) {
      Write-Verbose "ConvertFrom-Object: Incoming: $($Depth)"
      $Depth = if ($Depth -gt 1) { $Depth - 1 } else { $Depth }
      Write-Verbose "ConvertFrom-Object: Calculated: $($Depth)"
      if ($Object.schema) {
        Write-Verbose "ConvertFrom-Object: Found: $($Object.schema)"
        Add-Member -InputObject $retVal -MemberType NoteProperty -Name '$schema' -Value $Object.schema;
        if ($Object.id) {
          Write-Verbose "ConvertFrom-Object: Found: $($Object.id)"
          Add-Member -InputObject $retVal -MemberType NoteProperty -Name '$id' -Value $Object.id -force;
        }
      }
      foreach ($item in $Object.properties.keys) {
        Write-Verbose "ConvertFrom-Object: Found: $($item)"
        switch ($Object.properties.$item.type) {
          'object' {
            Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value (ConvertFrom-SchemaObject -Object $Object.properties.$item -depth $Depth)
          }
          'array' {
            Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value @(ConvertFrom-SchemaArray -Array $Object.properties.$item -depth $Depth)
          }
          'string' {
            Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value $Object.properties.$item.default
          }
          'number' {
            Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value $Object.properties.$item.default
          }
          'integer' {
            Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value $Object.properties.$item.default
          }
          'boolean' {
            Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value $Object.properties.$item.default
          }
          default {
            Add-Member -InputObject $retVal -MemberType NoteProperty -Name $item -Value $Object.properties.$item.default
          }
        }
      }
    }
    return $retVal
  }
}
function ConvertFrom-Array {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/ConvertFrom-SchemaArray.md#convertfrom-schemaarray',
    PositionalBinding = $true)]
  [OutputType([array])]
  param (
    [parameter(Mandatory = $true, Position = 0)]
    $Array,
    [parameter(Mandatory = $false, Position = 1)]
    [int]$Depth
  )
  if ($Array.type -eq 'array') {
    [array]$retVal = @();
    if ($Depth -ne 1) {
      Write-Verbose "ConvertFrom-Array: Incoming: $($Depth)"
      $Depth = if ($Depth -gt 1) { $Depth - 1 } else { $Depth }
      Write-Verbose "ConvertFrom-Array: Calculated: $($Depth)"
      foreach ($item in $Array.items) {
        Write-Verbose "ConvertFrom-Array: Found: $($item |Out-string)"
        foreach ($key in $item.psobject.Properties.name) {
          Write-Verbose "ConvertFrom-Array: Found: $($key)"
          $retVal += (ConvertFrom-SchemaObject -Object $item.$key -depth $Depth)
        }
      }
    }
    return $retVal
  }
}
function Format-Document {
  [CmdletBinding(
    HelpURI = 'https://github.com/SchemaModule/PowerShell/blob/master/docs/Format-SchemaDocument.md#format-schemadodcument',
    PositionalBinding = $true)]
  [OutputType([string])]
  param (
    [Parameter(Mandatory, ValueFromPipeline)]
    [String] $json
  )
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