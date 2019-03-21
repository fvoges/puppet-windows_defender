# Puppet Task Name: status
#
# This is where you put the shell code for your task.
#
# You can write Puppet tasks in any language you want and it's easy to
# adapt an existing Python, PowerShell, Ruby, etc. script. Learn more at:
# https://puppet.com/docs/bolt/0.x/writing_tasks.html
#
# Puppet tasks make it easy for you to enable others to use your script. Tasks
# describe what it does, explains parameters and which are required or optional,
# as well as validates parameter type. For examples, if parameter "instances"
# must be an integer and the optional "datacenter" parameter must be one of
# portland, sydney, belfast or singapore then the .json file
# would include:
#   "parameters": {
#     "instances": {
#       "description": "Number of instances to create",
#       "type": "Integer"
#     },
#     "datacenter": {
#       "description": "Datacenter where instances will be created",
#       "type": "Enum[portland, sydney, belfast, singapore]"
#     }
#   }
# Learn more at: https://puppet.com/docs/bolt/0.x/writing_tasks.html#ariaid-title11
#
# Original script obtained from (MIT license)
#  https://gallery.technet.microsoft.com/scriptcenter/PowerShell-to-Check-if-811b83bc
Try
{
    $defenderOptions = Get-MpComputerStatus

    if([string]::IsNullOrEmpty($defenderOptions))
    {
        Write-host "Windows Defender was not found running on the Server:" $env:computername -foregroundcolor "Green"
    }
    else
    {
        Write-host "Windows Defender was found on the Server:" $env:computername -foregroundcolor "Cyan"
        Write-host "   Is Windows Defender Enabled?" $defenderOptions.AntivirusEnabled
        Write-host "   Is Windows Defender Service Enabled?" $defenderOptions.AMServiceEnabled
        Write-host "   Is Windows Defender Antispyware Enabled?" $defenderOptions.AntispywareEnabled
        Write-host "   Is Windows Defender OnAccessProtection Enabled?"$defenderOptions.OnAccessProtectionEnabled
        Write-host "   Is Windows Defender RealTimeProtection Enabled?"$defenderOptions.RealTimeProtectionEnabled
    }
}
Catch
{
    Write-host "Windows Defender was not found running on the Server:" $env:computername -foregroundcolor "Green"
}
