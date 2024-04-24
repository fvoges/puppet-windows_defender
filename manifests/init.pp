# Simple module to manage Widows Defender
#
# @summary Manage Windows Defender antivirus
#
# @example Basic example
#   include windows_defender
# @param allow_disabling
#   Allow disabling Windows Defender
# @param update_before_scan
#   Update virus definitions before a scan
# @param ui_lockdown
#   Headless UI mode.  Makes it impossible for users to interact with the interface
# @param purge_exclusions
#   Remove all exclusions form Windows Defender
class windows_defender (
  Boolean $allow_disabling    = true,
  Boolean $update_before_scan = true,
  Boolean $ui_lockdown        = false,
  Boolean $purge_exclusions   = false,
) {
  #Enforce Registry keys to manage Windows Defender settings

  #forces Windows Defender antivirus into a perpetually on state
  # Ensure the key exists
  registry_key { 'HKLM\Software\Policies\Microsoft\Windows Defender':
    ensure => present,
  }

  $_allow_disabling = $allow_disabling ? {
    true    => '1',
    default => '0',
  }

  #the meaning of this vaule is that the abillity to turn off Windows Defender is disabled
  # Set the value
  registry_value { 'HKLM\Software\Policies\Microsoft\Windows Defender\DisableAntiSpyware':
    ensure => present,
    type   => dword,
    data   => $_allow_disabling,
  }

  #update definitions before a scan
  # Ensure the key exists
  registry_key { 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan':
    ensure => present,
  }

  $_update_before_scan = $update_before_scan ? {
    true    => '1',
    default => '0',
  }

  #set the value
  registry_value { 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan\CheckForSignaturesBeforeRunningScan':
    ensure => present,
    type   => dword,
    data   => $_update_before_scan,
  }

  #enable headless UI mode (makes it impossible for users to interact w/ the interface)
  # Ensure the key exists
  registry_key { 'HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration':
    ensure => present,
  }

  $_ui_lockdown = $ui_lockdown ? {
    true    => '1',
    default => '0',
  }

  #set the value
  registry_value { 'HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration\UILockdown':
    ensure => present,
    type   => dword,
    data   => $_ui_lockdown,
  }

  if $purge_exclusions {
    #removes all exculsions from Windows Defender
    registry_key { 'HKLM\Software\Policies\Microsoft\Windows Defender\Exclusions':
      ensure => absent,
    }
  }
}
