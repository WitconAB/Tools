<#
.Synopsis
   (c) Witcon AB Kopiera grupper från en användare
.DESCRIPTION
   Kopierar gruppmedlemskap från en användare till en annan

.EXAMPLE
   Grupperna från Sourse sätts på destination extra grupper tas bort från Destination
   copy-WITusersgroups -SourceSam aa -DestinationSam bb -Deleteextragroups

.EXAMPLE
   Grupperna från Sourse som saknas adderas på destination 
   copy-WITusersgroups -SourceSam aa -DestinationSam bb 
#>
function copy-WITusersgroups
{
    [CmdletBinding()]
    
   
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $SourceSam,
         [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $DestinationSam,
         [Switch]$Deleteextragroups
       
    )

    Begin
    {
    

    }
    Process
    {
    $Sourcegroups=@()
    $Destgroups=@()
    $Sourcegroups+=Get-ADUser $SourceSam -Property MemberOf | Select -ExpandProperty MemberOf | Get-ADGroup | Select -ExpandProperty SamAccountName
    $Destgroups+=Get-ADUser $DestinationSam -Property MemberOf | Select -ExpandProperty MemberOf | Get-ADGroup | Select -ExpandProperty SamAccountName
    $compgroupsAdd=Compare-Object $Sourcegroups -DifferenceObject $Destgroups|where Sideindicator -eq '<=' |select -ExpandProperty Inputobject
    $compgroupsDelete=Compare-Object $Sourcegroups -DifferenceObject $Destgroups|where Sideindicator -eq '=>' |select -ExpandProperty Inputobject
    Write-Host "Groups added" 
    $compgroupsAdd
    $compgroupsAdd|% {
      Add-ADGroupMember -Identity $_ -Members $DestinationSam 
      }
    if ($Deleteextragroups) {
       write-host "Groups Removed "
       $compgroupsDelete
       $compgroupsDelete |% {
       Remove-ADGroupMember -Identity $_ -Members $DestinationSam -Confirm:$false
       }
    }

    }
    End
    {
    }
}



