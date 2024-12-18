﻿function New-PSSemVer {
    <#
        .SYNOPSIS
        Creates a new PSSemVer object.

        .DESCRIPTION
        This function creates a new PSSemVer object.

        .EXAMPLE
        New-SemVer -Version '1.2.3-alpha.1+001'

        Major         : 1
        Minor         : 2
        Patch         : 3
        Prerelease    : alpha.1
        BuildMetadata : 001

        .EXAMPLE
        New-SemVer -Major 1 -Minor 2 -Patch 3 -Prerelease 'alpha.1' -BuildMetadata '001'

        Major         : 1
        Minor         : 2
        Patch         : 3
        Prerelease    : alpha.1
        BuildMetadata : 001

        .NOTES
        Compatible with SemVer 2.0.0.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSUseShouldProcessForStateChangingFunctions', '',
        Justification = 'Does not change system state, but creates a new object.'
    )]
    [OutputType([PSSemVer])]
    [CmdletBinding(DefaultParameterSetName = 'Values')]
    param (
        # The major version.
        [Parameter(ParameterSetName = 'Values')]
        [int] $Major = 0,

        # The minor version.
        [Parameter(ParameterSetName = 'Values')]
        [int] $Minor = 0,

        # The patch version.
        [Parameter(ParameterSetName = 'Values')]
        [int] $Patch = 0,

        # The prerelease version.
        [Parameter(ParameterSetName = 'Values')]
        [Parameter(ParameterSetName = 'String')]
        [Alias('PreReleaseLabel')]
        [string] $Prerelease = '',

        # The build metadata.
        [Parameter(ParameterSetName = 'Values')]
        [Parameter(ParameterSetName = 'String')]
        [Alias('Build', 'BuildLabel')]
        [string] $BuildMetadata = '',

        # The version as a string.
        [Parameter(
            Mandatory,
            ParameterSetName = 'String'
        )]
        [AllowEmptyString()]
        [string] $Version
    )

    switch ($PSCmdlet.ParameterSetName) {
        'Values' {
            return [PSSemVer]::New($Major, $Minor, $Patch, $Prerelease, $BuildMetadata)
        }
        'String' {
            if ([string]::IsNullOrEmpty($Version)) {
                $Version = '0.0.0'
            }
            $obj = [PSSemVer]::New($Version)
            if ($BuildMetadata) {
                $obj.SetBuildMetadata($BuildMetadata)
            }
            if ($Prerelease) {
                $obj.SetPrerelease($Prerelease)
            }
            return $obj
        }
    }
}
