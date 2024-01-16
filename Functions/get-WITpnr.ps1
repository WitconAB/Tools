<#
.Synopsis
   (c) Witcon AB Formaterar personnr
.DESCRIPTION
  Indata personnr 10 -13 tecken
  Verson 1.1.1.1 Formatering i scriptet.

 Utdata     
   full13 = ååååmmdd-xxxx
   full12 = ååååmmddxxxx
   full8 = ååååmmdd
   short11 = ååmmdd-xxxx
   short10 = ååmmddxxxx
#>

Function Get-WitPnr {
    [CmdletBinding()]
    param(
    [Parameter(Mandatory=$true,
          
                   Position=0)]
        [string]$Personnr,
         [ValidateSet("Full13", "Full12","Full8","Short11", "Short10")]
        $typ 
    )
	
	$Personnr = $Personnr.Replace("-", "")
	$Personnr = $Personnr.trim()
 if ($Personnr.length -ge 12) {
   $far=$Personnr.Substring(0,2)
   $Fpnrdate = $Personnr.Substring(2, 6)
   $Fpnrnr = $Personnr.Substring(8, 4)
 } else {
   [string]$FDate=get-date -Format yyMMdd
   $Fspnr=$Personnr.Substring(0,2)
   $fsdate=$FDate.Substring(0,2)
   if ($fsdate -lt $Fspnr)
		{
			$far = 19
		}
		else
		{
			$far = 20
		}
   $Fpnrdate = $Personnr.Substring(0, 6)
   $Fpnrnr = $Personnr.Substring(6, 4)
 }



 if ($typ -eq 'Full13') {
    $Fpnr = "$far$Fpnrdate-$Fpnrnr"
 } elseif ($typ -eq 'Full12') {
   $Fpnr="$far$Fpnrdate$Fpnrnr"
 } elseif ($typ -eq 'Short11') {
   $Fpnr="$Fpnrdate-$Fpnrnr"
 } elseif ($typ -eq 'Full8') {
   $Fpnr="$far$Fpnrdate"
 } elseif ($typ -eq 'Short11') {
   $Fpnr="$Fpnrdate-$Fpnrnr"
 } else {
   $Fpnr="$Fpnrdate$Fpnrnr"
 }
 $Fpnr
}

