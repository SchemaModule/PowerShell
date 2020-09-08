function Get-SchemaDocument {
  param (
    [string]$Path
  )

  try {
    $ErrorActionPreference = 'Stop';
    $Error.Clear();

    $Schema = [System.UriBuilder]::new($Path);

    switch ($Schema.Scheme) {
      'file' {
        Get-Content -Path $Path |ConvertFrom-Json
      }
      'https' {
        Invoke-WebRequest -UseBasicParsing -Uri $Path |Select-Object -ExpandProperty Content |ConvertFrom-Json
      }
      'http' {
        Invoke-WebRequest -UseBasicParsing -Uri $Path |Select-Object -ExpandProperty Content |ConvertFrom-Json
      }
    }
  } catch {
    throw $_
  }
}
function Get-SchemaObject {
  param (
    [object]$Schema
  )
  $Properties = $Schema.properties |Get-Member -MemberType NoteProperty |Select-Object -ExpandProperty Name;
  $Members = @{};
  foreach ($Property in $Properties) {
    switch ($Schema.properties.$Property.type) {
      'object' {
        $Members.Add($Property,(New-Object -TypeName psobject -Property @{}))
      }
      'array' {
        $Members.Add($Property,@())
      }
      'string' {
        $Members.Add($Property,"")
      }
      'number' {
        $Members.Add($Property,[Int16]"")
      }
    }
  }
  New-Object -TypeName psobject -Property $Members;
}
function Get-SchemaArray {
  param (
    [object]$Schema
  )
  $Properties = $Schema.items.anyOf.properties |Get-Member -MemberType NoteProperty |Select-Object -ExpandProperty Name;
  $Members = @{};
  foreach ($Property in $Properties) {
    switch ($Schema.items.anyOf.properties.$Property.type) {
      'object' {
        $Members.Add($Property,(New-Object -TypeName psobject -Property @{}))
      }
      'array' {
        $Members.Add($Property,@())
      }
      'string' {
        $Members.Add($Property,"")
      }
      'number' {
        $Members.Add($Property,[Int16]"")
      }
    }
  }
  New-Object -TypeName psobject -Property $Members;
}
function Get-SchemaProperty {
  param (
    [object]$Schema,
    [string]$Name
  )
  if ($Name) {
    $Schema.properties.$Name;
  } else {
    $Schema.properties;
  }
}
function New-RootDocument {
  param (
    [string]$Path
  )

  try {
    $ErrorActionPreference = 'Stop';
    $Error.Clear();

    $Schema = Get-SchemaDocument -Path $Path;
    $rootDocument = Get-SchemaObject -Schema $Schema;
    $rootDocument |Add-Member -MemberType NoteProperty -Name '$schema' -Value ($Schema.'$id')
    return $rootDocument
  } catch {

  }
}