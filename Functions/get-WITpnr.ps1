Function Get-WitPnr {
    [CmdletBinding()]
    param(
    [Parameter(Mandatory=$true,
          
                   Position=0)]
        [string]$Personnr,
         [ValidateSet("full13", "full12","Full8","short11", "short10")]
        $typ 
    )
 $Personnr=$Personnr.Replace("-","")
 [string]$FDate=get-date -Format yyMMdd
 $Fspnr=$Personnr.Substring(0,2)
 $fsdate=$FDate.Substring(0,2)
 if ($fsdate -lt $Fspnr) {$far=19} else {$far=20}
 $Fpnrdate=$Personnr.Substring(0,6)
 $Fpnrnr=$Personnr.Substring(6,4)
 if ($typ -eq 'full13') {
    $Fpnr = "$far$Fpnrdate-$Fpnrnr"
 } elseif ($typ -eq 'full12') {
   $Fpnr="$far$Fpnrdate$Fpnrnr"
 } elseif ($typ -eq 'short11') {
   $Fpnr="$Fpnrdate-$Fpnrnr"
 } elseif ($typ -eq 'Full8') {
   $Fpnr="$far$Fpnrdate"
 } elseif ($typ -eq 'short11') {
   $Fpnr="$Fpnrdate-$Fpnrnr"
 } else {
   $Fpnr="$Fpnrdate$Fpnrnr"
 }
 $Fpnr
}

