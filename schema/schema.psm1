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
          Get-Content -Path $Path | ConvertFrom-Json;
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