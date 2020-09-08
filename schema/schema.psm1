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
    try {
      $ErrorActionPreference = 'Stop';
      $Error.Clear();

      $Schema = [System.UriBuilder]::new($Path);

      switch ($Schema.Scheme) {
        'file' {
          Get-Content -Path $Path | ConvertFrom-Json;
        }
        'https' {
          Invoke-WebRequest -UseBasicParsing -Uri $Path | Select-Object -ExpandProperty Content | ConvertFrom-Json;
        }
        'http' {
          Invoke-WebRequest -UseBasicParsing -Uri $Path | Select-Object -ExpandProperty Content | ConvertFrom-Json;
        }
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
    $Properties = $SchemaDocument.properties | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name;
    $Members = @{};
    foreach ($Property in $Properties) {
      switch ($SchemaDocument.properties.$Property.type) {
        'object' {
          $Members.Add($Property, (New-Object -TypeName psobject -Property @{}))
        }
        'array' {
          $Members.Add($Property, @())
        }
        'string' {
          $Members.Add($Property, "")
        }
        'number' {
          $Members.Add($Property, [Int16]"")
        }
      }
    }
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
    $Properties = $SchemaDocument.items.anyOf.properties | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name;
    $Members = @{};
    foreach ($Property in $Properties) {
      switch ($SchemaDocument.items.anyOf.properties.$Property.type) {
        'object' {
          $Members.Add($Property, (New-Object -TypeName psobject -Property @{}))
        }
        'array' {
          $Members.Add($Property, @())
        }
        'string' {
          $Members.Add($Property, "")
        }
        'number' {
          $Members.Add($Property, [Int16]"")
        }
      }
    }
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
    if ($Name) {
      $SchemaDocument.properties.$Name;
    }
    else {
      $SchemaDocument.properties;
    }
  }
}