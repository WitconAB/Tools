
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Add-WITdhcpscope
{
    [CmdletBinding()]
    
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $name="tempscopename",
         [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $scope='172.16.255.0/24',
        $Scopestart = '100',
        $Scopeend = '229',
        $Gateway='1',
        $dnsservers,
        $dnssuffix,
        $LeaseDuration ='8.0:0:0',
        $State ='Active',
        $Server='localhost',
        $failoverserver
    )

    Begin
    {
    }
    Process
    {
    $Wrkscope=$scope.split('/')
    $wrkmask=get-WITsubnet $Wrkscope[1]
    $wrknets=$Wrkscope[0].split('.')
    $wrknet=$wrkscope[0].substring(0,($Wrkscope[0].length-$wrknets[3].length))
    Add-DhcpServerv4Scope -computer $server -EndRange $wrknet$Scopeend -Name $name'_dhcp' -StartRange $wrknet$Scopestart -SubnetMask $wrkmask -LeaseDuration  $LeaseDuration -State $state -Type Dhcp
    Set-DhcpServerv4OptionValue -ScopeId $Wrkscope[0] -Router $wrknet$Gateway 
    if ($dnssuffix.Length -ge 1) {
    Set-DhcpServerv4OptionValue -ScopeId $Wrkscope[0] -DnsDomain  $dnssuffix
    }
    if ($dnsservers.Length -ge 1) {
    Set-DhcpServerv4OptionValue -ScopeId $Wrkscope[0] -DnsServer $dnsservers -Force
    }
    if ($failoverserver.Length -ge 1 )
    {
    $failname=@()
    $failname+=Get-DhcpServerv4Failover |where  partnerserver -eq $failoverserver
    Add-DhcpServerv4FailoverScope -ScopeId $Wrkscope[0] -Name $failname[0].name 

   #    add-DhcpServerv4Failover -ScopeId $Wrkscope[0] -PartnerServer $failoverserver -Name $name'_failover'
    }

    }
    End
    {
    }
}

