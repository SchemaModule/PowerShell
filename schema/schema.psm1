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
          Get-Content -Path $Path | ConvertFrom-Json;
        }
        'https' {
          Write-Verbose "Incoming HTTPs path";
          Invoke-WebRequest -UseBasicParsing -Uri $Path | Select-Object -ExpandProperty Content | ConvertFrom-Json;
        }
        'http' {
          Write-Verbose "Incoming HTTP path";
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