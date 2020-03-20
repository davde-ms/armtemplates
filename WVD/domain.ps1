Get-Disk | Where-Object PartitionStyle –Eq "RAW"| Initialize-Disk -PartitionStyle GPT
Get-Disk -Number 2 | New-Partition -UseMaximumSize -DriveLetter F | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Logs" -Confirm:$False      

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

$domain = 'domainfqdn.extension'
$NTDSPath = 'C:\Windows\NTDS'
$NTDSLogPath = 'F:\Windows\NTDS'
$SYSVOLPath = 'C:\Windows\SYSVOL'
$Site  = "Default-First-Site-Name"


Import-Module ADDSDeployment

Install-ADDSDomainController `

-NoGlobalCatalog:$false `

-CreateDnsDelegation:$false `

-Credential (Get-Credential domain\username) `

-CriticalReplicationOnly:$false `

-DatabasePath $NTDSPath `

-DomainName $domain `

-InstallDns:$true `

-LogPath $NTDSLogPath `

-NoRebootOnCompletion:$false `

-SiteName $Site `

-SysvolPath $SYSVOLPath `

-SafeModeAdministratorPassword (ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force) `

-SkipPreChecks

-Force:$true