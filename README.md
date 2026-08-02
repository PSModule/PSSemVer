# PSSemVer

PSSemVer adds a [Semantic Versioning 2.0.0](https://semver.org/) compatible `[PSSemVer]` class to PowerShell, plus the commands to
create and convert it. Unlike the built-in `[version]` type, it understands prerelease labels, build metadata, and tag prefixes such
as `v1.2.3`, and it compares versions using the precedence rules from the SemVer specification.

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name PSSemVer
Import-Module -Name PSSemVer
```

## Capabilities

Parse a version from a string, including prerelease, build metadata, and a tag prefix:

```powershell
$version = New-PSSemVer -Version 'v1.2.3-alpha.1+001'
$version.Prefix        # v
$version.Major         # 1
$version.Prerelease    # alpha.1
$version.BuildMetadata # 001
```

Compare versions using SemVer precedence, so prereleases sort before their release:

```powershell
[PSSemVer]'1.0.0-beta.2' -lt [PSSemVer]'1.0.0-beta.11'  # True
[PSSemVer]'1.0.0-rc.1' -lt [PSSemVer]'1.0.0'            # True
```

Bump a version in place, including the prerelease counter:

```powershell
$version = New-PSSemVer -Version '1.2.3'
$version.BumpMinor()               # 1.3.0
$version.SetPrerelease('alpha')    # 1.3.0-alpha
$version.BumpPrereleaseNumber()    # 1.3.0-alpha.1
```

Convert values coming off the pipeline and sort them by SemVer precedence:

```powershell
'1.0.0', '0.9.0', '1.0.0-rc.1' | ConvertTo-PSSemVer | Sort-Object
# 0.9.0
# 1.0.0-rc.1
# 1.0.0
```

## Documentation

Documentation is published at [psmodule.io/PSSemVer](https://psmodule.io/PSSemVer/).

Use PowerShell help and command discovery for module details:

```powershell
Get-Command -Module PSSemVer
Get-Help -Name New-PSSemVer -Examples
```
