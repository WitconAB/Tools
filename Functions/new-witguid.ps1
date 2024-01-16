<#
.Synopsis
   Skapar en ny guid med eller utan {}
.DESCRIPTION
   $Without  Switch som tarbort {} om guid

.EXAMPLE
   new-WITguid
.EXAMPLE
   new-WITguid -without
#>
Function New-WITguid
  {
    [CmdletBinding()]
    Param
    (
       [Switch]$Without

    )

  
  $temp=[guid]::NewGuid().guid

  if ($Without -eq $true)
    {
      return "$temp"
    } else {
      return "{$temp}"
    }
  }