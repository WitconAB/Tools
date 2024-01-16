﻿
<#
.Synopsis
   Ovandlar /x subnet till x.x.x.x mask
   /x kan var 0-32
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function get-WITsubnet
{
    [CmdletBinding()]
    
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $subnet
    )

    Begin
    {
    }
    Process
    {
    switch ($subnet)
    {
        '32' {'255.255.255.255'}
        '31' {'255.255.255.254'}
        '30' {'255.255.255.252'}
        '29' {'255.255.255.248'}
        '28' {'255.255.255.240'}
        '27' {'255.255.255.224'}
        '26' {'255.255.255.192'}
        '25' {'255.255.255.128'}
        '24' {'255.255.255.0'}
        '23' {'255.255.254.0'}
        '22' {'255.255.252.0'}
        '21' {'255.255.248.0'}
        '20' {'255.255.240.0'}
        '19' {'255.255.224.0'}
        '18' {'255.255.192.0'}
        '17' {'255.255.128.0'}
        '16' {'255.255.0.0'}
        '15' {'255.254.0.0'}
        '14' {'255.252.0.0'}
        '13' {'255.248.0.0'}
        '12' {'255.240.0.0'}
        '11' {'255.224.0.0'}
        '10' {'255.192.0.0'}
        '9' {'255.128.0.0'}
        '8' {'255.0.0.0'}
        '7' {'254.0.0'}
        '6' {'252.0.0'}
        '5' {'248.0.0'}
        '4' {'240.0.0'}
        '3' {'224.0.0'}
        '2' {'192.0.0'}
        '1' {'128.0.0'}
        '0' {'0.0.0.0'}
        Default {'Error'}
    }
    }
    End
    {
    }
}