# PSSemVer

This module introduces a SemVer 2.0.0 compatible class for PowerShell.

## Prerequisites

No prerequisites.

## Installation

To install the module and class run the following command:

```powershell
Install-Module -Name PSSemVer
Import-Module -Name PSSemVer
```

## Usage

Here is a list of example that are typical use cases for the module.
This section should provide a good overview of the module's capabilities.

### Create a new SemVer object

```powershell
$Version = New-PSSemVer -Version 1.0.0
```

### Create a new SemVer object with prerelease and build metadata

```powershell
$Version = New-PSSemVer -Version 1.0.0 -PreRelease 'alpha' -Build '2020-01-01'
```

### Create a new SemVer object from a string

```powershell
$Version = New-PSSemVer -Version '1.0.0-alpha+2020-01-01'
```

### Compare two SemVer objects

```powershell
$Version1 = New-PSSemVer -Version 1.0.0
$Version2 = New-PSSemVer -Version 1.0.1
$Version1 -lt $Version2
>_ true
```

### Increment the major version

```powershell
$Version = New-PSSemVer -Version 1.0.0
$Version.BumpMajor()
```

### Increment the minor version

```powershell
$Version = New-PSSemVer -Version 1.0.0
$Version.BumpMinor()
```

### Increment the patch version

```powershell
$Version = New-PSSemVer -Version 1.0.0
$Version.BumpPatch()
```

### Set the prerelease

```powershell
$Version = New-PSSemVer -Version 1.0.0
$Version.SetPreRelease('alpha')
```

## Contributing

Coder or not, you can contribute to the project! We welcome all contributions.

### For Users

If you don't code, you still sit on valuable information that can make this project even better. If you experience that the
product does unexpected things, throw errors or is missing functionality, you can help by submitting bugs and feature requests.
Please see the issues tab on this project and submit a new issue that matches your needs.

### For Developers

If you do code, we'd love to have your contributions. Please read the [Contribution guidelines](CONTRIBUTING.md) for more information.
You can either help by picking up an existing issue or submit a new one if you have an idea for a new feature or improvement.

## Links

- [Semantic Versioning 2.0.0](https://semver.org/)
