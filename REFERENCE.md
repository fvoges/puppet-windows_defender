# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

**Classes**

* [`windows_defender`](#windows_defender): Manage Windows Defender antivirus

**Tasks**

* [`status`](#status): Check status of Windows Defender

## Classes

### windows_defender

Simple module to manage Widows Defender

#### Examples

##### Basic example

```puppet
include windows_defender
```

#### Parameters

The following parameters are available in the `windows_defender` class.

##### `allow_disabling`

Data type: `Boolean`

Allow disabling Windows Defender

Default value: `true`

##### `update_before_scan`

Data type: `Boolean`

Update virus definitions before a scan

Default value: `true`

##### `ui_lockdown`

Data type: `Boolean`

Headless UI mode.  Makes it impossible for users to interact with the interface

Default value: `false`

##### `purge_exclusions`

Data type: `Boolean`

Remove all exclusions form Windows Defender

Default value: `false`

## Tasks

### status

Check status of Windows Defender

**Supports noop?** false
