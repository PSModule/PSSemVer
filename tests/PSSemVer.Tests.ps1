[CmdletBinding()]
Param(
    # Path to the module to test.
    [Parameter()]
    [string] $Path
)

Write-Verbose "Path to the module: [$Path]" -Verbose

Describe 'PSSemVer' {
    Describe 'Function: New-PSSemVer' {
        It "'New-PSSemVer -Major 1 -Minor 2 -Patch 3' => '1.2.3'" {
            $PSSemVer = New-PSSemVer -Major 1 -Minor 2 -Patch 3
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Prerelease 'alpha' => '1.2.3-alpha'" {
            $PSSemVer = New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Prerelease 'alpha'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha'
        }
        It "New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Build '654646554' => '1.2.3+654646554'" {
            $PSSemVer = New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Build '654646554'
            $PSSemVer.BuildMetadata | Should -Be '654646554'
        }
        It "New-PSSemVer => '0.0.0'" {
            $PSSemVer = New-PSSemVer
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "New-PSSemVer -Version '' => '0.0.0'" {
            $PSSemVer = New-PSSemVer -Version ''
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "New-PSSemVer -Version '1.2.3' => '1.2.3'" {
            $PSSemVer = New-PSSemVer -Version '1.2.3'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
    }

    Describe 'Function: ConvertTo-PSSemVer' {
        It "ConvertTo-PSSemVer -Version '1.2.3' => '1.2.3'" {
            $PSSemVer = ConvertTo-PSSemVer -Version '1.2.3'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
        }
        It "'1.2.3' | ConvertTo-PSSemVer => '1.2.3'" {
            $PSSemVer = '1.2.3' | ConvertTo-PSSemVer
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
        }
        It "ConvertTo-PSSemVer -Version '1.2.3-alpha.1+1' => '1.2.3-alpha.1+1'" {
            $PSSemVer = ConvertTo-PSSemVer -Version '1.2.3-alpha.1+1'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -Be '1'
        }
        It "`$null | ConvertTo-PSSemVer => '0.0.0'" {
            $PSSemVer = $null | ConvertTo-PSSemVer
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "'' | ConvertTo-PSSemVer => '0.0.0'" {
            $PSSemVer = '' | ConvertTo-PSSemVer
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
    }

    Describe 'Class: Constructor' {
        It "[PSSemVer]'1.2.3' => '1.2.3'" {
            $PSSemVer = [PSSemVer]'1.2.3'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
        }
        It "[PSSemVer]'1.2.3-alpha.1' => '1.2.3-alpha.1" {
            $PSSemVer = [PSSemVer]'1.2.3-alpha.1'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
        }
        It "[PSSemVer]'1.2.3-alpha.1+001' => '1.2.3-alpha.1+001'" {
            $PSSemVer = [PSSemVer]'1.2.3-alpha.1+001'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -Be '001'
        }
        It "[Version]'1.2' => [PSSemVer]'1.2.0'" {
            $Version = [Version]'1.2'
            $PSSemVer = [PSSemVer]$Version
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 0
        }
        It "[Version]'1.2.3' => [PSSemVer]'1.2.3'" {
            $Version = [Version]'1.2.3'
            $PSSemVer = [PSSemVer]$Version
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
        }
        It "[Version]'1.2.3.10' => [PSSemVer]'1.2.3'" {
            $Version = [Version]'1.2.3.10'
            $PSSemVer = [PSSemVer]$Version
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
        }
        It "Throws on [PSSemVer]'1.0.0-beta..1'" {
            { [PSSemVer]'1.0.0-beta..1' } | Should -Throw
        }

        It "Throws on [PSSemVer]'1.0.0-beta.!.1'" {
            { [PSSemVer]'1.0.0-beta.!.1' } | Should -Throw
        }

        It "Throws on [PSSemVer]'1.0.0-beta!1'" {
            { [PSSemVer]'1.0.0-beta!1' } | Should -Throw
        }
    }

    Describe 'Class: ToString()' {
        It "New-PSSemVer -Major 1 -Minor 2 -Patch 3 => '1.2.3'" {
            $PSSemVer = New-PSSemVer -Major 1 -Minor 2 -Patch 3
            Write-Verbose ($PSSemVer.ToString()) -Verbose
            $PSSemVer.ToString() | Should -Be '1.2.3'
        }
        It "New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Prerelease 'alpha.1' -Build '001' => '1.2.3-alpha.1+001'" {
            $PSSemVer = New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Prerelease 'alpha.1' -Build '001'
            Write-Verbose ($PSSemVer.ToString())
            $PSSemVer.ToString() | Should -Be '1.2.3-alpha.1+001'
        }
        It "New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Prerelease 'alpha.1' => '1.2.3-alpha.1'" {
            $PSSemVer = New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Prerelease 'alpha.1'
            Write-Verbose ($PSSemVer.ToString())
            $PSSemVer.ToString() | Should -Be '1.2.3-alpha.1'
        }
        It "New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Build '001' => '1.2.3+001'" {
            $PSSemVer = New-PSSemVer -Major 1 -Minor 2 -Patch 3 -Build '001'
            Write-Verbose ($PSSemVer.ToString())
            $PSSemVer.ToString() | Should -Be '1.2.3+001'
        }
    }

    Describe 'Class: Bump versions' {
        It "New-PSSemVer -Major 1 -Minor 2 -Patch 3 + BumpMajor() => '2.0.0'" {
            $PSSemVer = New-PSSemVer -Major 1 -Minor 2 -Patch 3
            $PSSemVer.BumpMajor()
            $PSSemVer.Major | Should -Be 2
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
        }
        It "New-PSSemVer -Major 2 -Minor 1 -Patch 2 + BumpMinor() => '2.2.0'" {
            $PSSemVer = New-PSSemVer -Major 2 -Minor 1 -Patch 2
            $PSSemVer.BumpMinor()
            $PSSemVer.Major | Should -Be 2
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 0
        }
        It "New-PSSemVer -Major 2 -Minor 1 -Patch 1 + BumpPatch() => '2.1.2'" {
            $PSSemVer = New-PSSemVer -Major 2 -Minor 1 -Patch 1
            $PSSemVer.BumpPatch()
            $PSSemVer.Major | Should -Be 2
            $PSSemVer.Minor | Should -Be 1
            $PSSemVer.Patch | Should -Be 2
        }
        It "New-PSSemVer -Major 2 -Minor 1 -Patch 1 -Prerelease 'alpha' + BumpPrereleaseNumber() => '2.1.1-alpha.1'" {
            $PSSemVer = New-PSSemVer -Major 2 -Minor 1 -Patch 1 -Prerelease 'alpha'
            $PSSemVer.BumpPrereleaseNumber()
            $PSSemVer.Major | Should -Be 2
            $PSSemVer.Minor | Should -Be 1
            $PSSemVer.Patch | Should -Be 1
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
        }
        It "New-PSSemVer -Major 2 -Minor 1 -Patch 1 -Prerelease 'alpha.1' + BumpPrereleaseNumber() => '2.1.1-alpha.2'" {
            $PSSemVer = New-PSSemVer -Major 2 -Minor 1 -Patch 1 -Prerelease 'alpha.1'
            $PSSemVer.BumpPrereleaseNumber()
            $PSSemVer.Major | Should -Be 2
            $PSSemVer.Minor | Should -Be 1
            $PSSemVer.Patch | Should -Be 1
            $PSSemVer.Prerelease | Should -Be 'alpha.2'
        }
    }

    Describe 'Class: Set prerelease and metadata' {
        It "New-PSSemVer + SetPreRelease('alpha') => '0.0.0-alpha'" {
            $PSSemVer = New-PSSemVer
            $PSSemVer.SetPreRelease('alpha')
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -Be 'alpha'
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "New-PSSemVer + SetBuildLabel('001') => '0.0.0+001'" {
            $PSSemVer = New-PSSemVer
            $PSSemVer.SetBuildLabel('001')
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -Be '001'
        }
        It "New-PSSemVer -Prerelease 'alpha' + SetPreReleaseLabel('') => '0.0.0'" {
            $PSSemVer = New-PSSemVer -Prerelease 'alpha'
            $PSSemVer.SetPreReleaseLabel('')
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "New-PSSemVer -Prerelease 'alpha' + SetPreReleaseLabel(`$null) => '0.0.0'" {
            $PSSemVer = New-PSSemVer -Prerelease 'alpha'
            $PSSemVer.SetPreReleaseLabel($null)
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "New-PSSemVer -Build '001' + SetBuildLabel('') => '0.0.0'" {
            $PSSemVer = New-PSSemVer -Build '001'
            $PSSemVer.SetBuildLabel('')
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "New-PSSemVer -Build '001' + SetBuildLabel(`$null) => '0.0.0'" {
            $PSSemVer = New-PSSemVer -Build '001'
            $PSSemVer.SetBuildLabel($null)
            $PSSemVer.Major | Should -Be 0
            $PSSemVer.Minor | Should -Be 0
            $PSSemVer.Patch | Should -Be 0
            $PSSemVer.Prerelease | Should -BeNullOrEmpty
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
    }

    Describe 'Class: Parse' {
        It "[PSSemVer]::Parse('1.2.3') => '1.2.3'" {
            $PSSemVer = [PSSemVer]::Parse('1.2.3')
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
        }
        It "[PSSemVer]::Parse('1.2.3-alpha.1') => '1.2.3-alpha.1'" {
            $PSSemVer = [PSSemVer]::Parse('1.2.3-alpha.1')
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -BeNullOrEmpty
        }
        It "[PSSemVer]::Parse('1.2.3-alpha.1+001') => '1.2.3-alpha.1+001'" {
            $PSSemVer = [PSSemVer]::Parse('1.2.3-alpha.1+001')
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -Be '001'
        }
    }

    Describe 'Class: Comparison' {
        It "'1.2.3' < '1.2.4'" {
            $PSSemVer1 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('1.2.4')
            $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
        }
        It "'1.2.3' > '1.2.2'" {
            $PSSemVer1 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('1.2.2')
            $PSSemVer1 -gt $PSSemVer2 | Should -BeTrue
        }
        It "'1.2.3' == '1.2.3'" {
            $PSSemVer1 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer1 -eq $PSSemVer2 | Should -BeTrue
        }
        It "'1.2.3' != '1.2.4'" {
            $PSSemVer1 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('1.2.4')
            $PSSemVer1 -ne $PSSemVer2 | Should -BeTrue
        }
        It "'1.2.3' <= '1.2.3'" {
            $PSSemVer1 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer1 -le $PSSemVer2 | Should -BeTrue
        }
        It "'1.2.3' >= '1.2.3'" {
            $PSSemVer1 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer1 -ge $PSSemVer2 | Should -BeTrue
        }
        It "'1.2.3' <= '1.2.4'" {
            $PSSemVer1 = [PSSemVer]::Parse('1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('1.2.4')
            $PSSemVer1 -le $PSSemVer2 | Should -BeTrue
        }
        Context 'semver.org tests' {
            It "'1.0.0' < '2.0.0'" {
                $PSSemVer1 = [PSSemVer]::Parse('1.0.0')
                $PSSemVer2 = [PSSemVer]::Parse('2.0.0')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'2.0.0' < '2.1.0'" {
                $PSSemVer1 = [PSSemVer]::Parse('2.0.0')
                $PSSemVer2 = [PSSemVer]::Parse('2.1.0')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'2.1.0' < '2.1.1'" {
                $PSSemVer1 = [PSSemVer]::Parse('2.1.0')
                $PSSemVer2 = [PSSemVer]::Parse('2.1.1')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'1.0.0-alpha' < '1.0.0-alpha.1'" {
                $PSSemVer1 = [PSSemVer]::Parse('1.0.0-alpha')
                $PSSemVer2 = [PSSemVer]::Parse('1.0.0-alpha.1')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'1.0.0-alpha.1' < '1.0.0-alpha.beta'" {
                $PSSemVer1 = [PSSemVer]::Parse('1.0.0-alpha.1')
                $PSSemVer2 = [PSSemVer]::Parse('1.0.0-alpha.beta')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'1.0.0-alpha.beta' < '1.0.0-beta'" {
                $PSSemVer1 = [PSSemVer]::Parse('1.0.0-alpha.beta')
                $PSSemVer2 = [PSSemVer]::Parse('1.0.0-beta')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'1.0.0-beta' < '1.0.0-beta.2'" {
                $PSSemVer1 = [PSSemVer]::Parse('1.0.0-beta')
                $PSSemVer2 = [PSSemVer]::Parse('1.0.0-beta.2')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'1.0.0-beta.2' < '1.0.0-beta.11'" {
                $PSSemVer1 = [PSSemVer]::Parse('1.0.0-beta.2')
                $PSSemVer2 = [PSSemVer]::Parse('1.0.0-beta.11')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'1.0.0-beta.11' < '1.0.0-rc.1'" {
                $PSSemVer1 = [PSSemVer]::Parse('1.0.0-beta.11')
                $PSSemVer2 = [PSSemVer]::Parse('1.0.0-rc.1')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }

            It "'1.0.0-rc.1' < '1.0.0'" {
                $PSSemVer1 = [PSSemVer]::Parse('1.0.0-rc.1')
                $PSSemVer2 = [PSSemVer]::Parse('1.0.0')
                $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
            }
        }
    }

    Describe 'Class: Handles prefix' {
        It "Parses 'v1.2.3' to PSSemVer" {
            $PSSemVer = [PSSemVer]::Parse('v1.2.3')
            $PSSemVer.Prefix | Should -Be 'v'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
        }
        It "Parses 'v1.2.3-alpha.1+001' to PSSemVer" {
            $PSSemVer = [PSSemVer]::Parse('v1.2.3-alpha.1+001')
            $PSSemVer.Prefix | Should -Be 'v'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -Be '001'
        }
        It "Parses 'v-1.2.3-alpha.1+001' to PSSemVer" {
            $PSSemVer = [PSSemVer]::Parse('v-1.2.3-alpha.1+001')
            $PSSemVer.Prefix | Should -Be 'v'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -Be '001'
        }
        It "Parses 'v1.2.3-alpha.1+001' to PSSemVer" {
            $PSSemVer = [PSSemVer]::Parse('v1.2.3-alpha.1+001')
            $PSSemVer.Prefix | Should -Be 'v'
            $PSSemVer.Major | Should -Be 1
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -Be '001'
        }
        It "Parses 'v10.2.3-alpha.1+001' to PSSemVer" {
            $PSSemVer = [PSSemVer]::Parse('v10.2.3-alpha.1+001')
            $PSSemVer.Prefix | Should -Be 'v'
            $PSSemVer.Major | Should -Be 10
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -Be '001'
        }
        It "Parses 'vca10.2.3-alpha.1+001' to PSSemVer" {
            $PSSemVer = [PSSemVer]::Parse('vca10.2.3-alpha.1+001')
            $PSSemVer.Prefix | Should -Be 'vca'
            $PSSemVer.Major | Should -Be 10
            $PSSemVer.Minor | Should -Be 2
            $PSSemVer.Patch | Should -Be 3
            $PSSemVer.Prerelease | Should -Be 'alpha.1'
            $PSSemVer.BuildMetadata | Should -Be '001'
        }
        It "Compares 'v1.2.3' as less than 'v1.2.4'" {
            $PSSemVer1 = [PSSemVer]::Parse('v1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('v1.2.4')
            $PSSemVer1 -lt $PSSemVer2 | Should -BeTrue
        }
        It "Compares 'v1.2.3' as greater than 'v1.2.2'" {
            $PSSemVer1 = [PSSemVer]::Parse('v1.2.3')
            $PSSemVer2 = [PSSemVer]::Parse('v1.2.2')
            $PSSemVer1 -gt $PSSemVer2 | Should -BeTrue
        }
    }
}
