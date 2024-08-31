<#

    PowerShell $PROFILE for ams\spencer.salyer

    2018-10-22 - started using concfg for shell themes: https://github.com/lukesampson/concfg
                 also trying out scoop https://github.com/lukesampson/scoop
    2020-08-10 - Updated prompt to use poshgit
#>

# Import posh-git for git stuff
Import-Module posh-git -ErrorAction SilentlyContinue

# Set a fun shell title
$sessionShellTitle = "PS"
# now using concfg for colors
#$sessionBackgroundColor = "Black" # "DarkBlue" is dfault # "DarkGray" doesn't work so well without adjusting *everything* see: Get-PSReadlineOption | select *color*
$sessionForegroundColor = "Magenta" # $Host.UI.RawUI.ForegroundColor

# Set a size?
# $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size(160,5000)
<#
    Admin console settings
#>
# Detect if running as administrator
$isAdminSession = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
# ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

# Configure admin settings
if($isAdminSession) {
    $sessionShellTitle = "[ADMIN] $sessionShellTitle"
}

<#
CGI Proxy / NTLM credentials for current user

Alternative? Used in remote session successfully when below didn't work...
    unable to resolve package source 'https://www.powershellgallery.com/api/v2/'
    Turns out it isn't allowed through your proxy server, run this in your PowerShell session and try again:

    $webclient=New-Object System.Net.WebClient
    $webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    [Net.ServicePointManager]::SecurityProtocol = "tls12"

$webclient = New-Object System.Net.WebClient
$webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
[Net.ServicePointManager]::SecurityProtocol = "tls12"
[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()
[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
#>


<#
    Aliases

    Can't pass parameters to alias, need to instead define a function
#>
# Set-Alias -Name npp -Value "C:\Program Files (x86)\Notepad++\notepad++.exe" -option ReadOnly -ErrorAction SilentlyContinue
# Set-Alias -Name hd -Value "C:\bin\hd-x64.exe" -option ReadOnly  -ErrorAction SilentlyContinue
Set-Alias -Name vsc -Value "code" -option ReadOnly -ErrorAction SilentlyContinue


<#
    Misc. settings
#>
# Set some console colors n stuff
#$Host.UI.RawUI.WindowTitle = $sessionShellTitle
#$Host.UI.RawUI.BackgroundColor = $sessionBackgroundColor
#$Host.UI.RawUI.ForegroundColor = $sessionForegroundColor
#$Host.PrivateData.ErrorForegroundColor = 'Red'
#$Host.PrivateData.ErrorBackgroundColor = if ($isAdminSession) {'Yellow'} else {$sessionBackgroundColor}
#$Host.PrivateData.WarningForegroundColor = 'Magenta'
#$Host.PrivateData.WarningBackgroundColor = $sessionBackgroundColor
#$Host.PrivateData.DebugForegroundColor = 'Yellow'
#$Host.PrivateData.DebugBackgroundColor = $sessionBackgroundColor
#$Host.PrivateData.VerboseForegroundColor = 'Green'
#$Host.PrivateData.VerboseBackgroundColor = $sessionBackgroundColor
#$Host.PrivateData.ProgressForegroundColor = 'Cyan'
#$Host.PrivateData.ProgressBackgroundColor = $sessionBackgroundColor

# Set the starting directory
#Set-Location "d:\webdev"


<#

    The Prompt function is called every time a new prompt is printed...

    Will look something like this... (RED if admin):

    11:23:13 C:\dev\authoring\4.0_branches\OddIncrementBranch\_db_migrations\Version 4.0\Authoring
    [ADMIN] PS>
#>
# function prompt {
#     $fgColor = $sessionForegroundColor
#     $loc = Get-Location
#     $date = Get-Date -UFormat %T # https://blogs.technet.microsoft.com/heyscriptingguy/2015/01/23/create-custom-date-formats-with-powershell//

#     # Set title
#     $host.UI.RawUI.WindowTitle = "${sessionShellTitle}> ${loc}"

#     # Set prompt
#     $prompt = "PS>"

#     # Make it obvious if we're running as administrator
#     if($isAdminSession) {
#         $fgColor = "DarkGray" # This is more magenta-y in Monokai
#         $prompt = "[ADMIN] ${prompt}"
#     }

#     # Write the prompt
#     Write-Host "${date} ${loc}" -foreground $fgColor
#     Write-Host "${prompt}" -nonewline -foreground $fgColor
#     return " "
# }

function prompt {
    $fgColor = $sessionForegroundColor
    $loc = Get-Location
    $date = Get-Date -UFormat %T # https://blogs.technet.microsoft.com/heyscriptingguy/2015/01/23/create-custom-date-formats-with-powershell//

    # Set title
    $host.UI.RawUI.WindowTitle = "${sessionShellTitle}> ${loc}"

    # Set prompt
    $origLastExitCode = $LASTEXITCODE
    $prefix = ""

    # Make it obvious if we're running as administrator
    if ($isAdminSession) {
        $fgColor = "DarkGray" # This is more magenta-y in Monokai
        $prefix = "[ADMIN]"
    }

    # Override with DEBUG
    if ($PsDebugContext) {
        $fgColor = "White" # This is more orange-y in Monokai
        $prefix = "[DEBUG]"
    }

    $gitStatus = (Write-VcsStatus)

    Write-Host "${date} ${loc}" -ForegroundColor $fgColor
    if ($gitStatus) {
        Write-Host "$($gitStatus.Trim())"
    }
    Write-Host "${prefix}PS>" -nonewline -ForegroundColor $fgColor

    $LASTEXITCODE = $origLastExitCode

    return " "
}

function Copy-DirectoryStructure {
    param (
        [parameter( Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
        [alias('Source', 'From')]
        [string] $Path = (Get-Location),

        [parameter( Mandatory = $true, ValueFromPipeline = $true, Position = 1)]
        [alias('Dest', 'To')]
        [string] $Destination
    )

    #$Exclude += @('.svn*')

    Copy-Item -Path $Path -Destination $Destination -Filter { PSIsContainer } -Recurse -Force
}

function Start-AdminSession {
    Start-Process pwsh -Verb runAs
}

#[alias('sudo')]
function Invoke-AsAdministrator {
    # -NoNewWindow
    # Start-Process -Verb RunAs powershell.exe -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; .\install.ps1"
    if ($args.Length -eq 1) {
        Start-Process $args[0] -Verb 'runAs'
    }

    if ($args.Length -gt 1) {
        Start-Process $args[0] -ArgumentList $args[1..$args.Length] -Verb 'runAs'
    }
}
Set-Alias -Name sudo -Value 'Invoke-AsAdministrator' -option ReadOnly -ErrorAction SilentlyContinue

function New-SymbolicLink {
    param (
        [parameter( Mandatory = $false, ValueFromPipeline = $true, Position = 0)]
        [alias('Location')]
        [string] $Path = (Get-Location).ToString(),

        [parameter( Mandatory = $true, ValueFromPipeline = $true, Position = 1)]
        [alias('SymLink', 'SymbolicLink', 'SymLinkName')]
        [string] $Name,

        [parameter( Mandatory = $true, ValueFromPipeline = $true, Position = 2)]
        [alias('Target')]
        [string] $Value
    )

    $resolvedPath = (Resolve-Path $Path).ToString()
    $resolvedValue = (Resolve-Path $Value).ToString()

    Write-Host "Creating symbolic link [ $resolvedPath ] [ $Name ] --> [ $resolvedValue ]"

    if (-not $isAdminSession) {
        # -NoNewWindow seems to be an issue, oh well
        Start-Process pwsh -Verb runAs -Wait -ArgumentList '-NonInteractive', '-NoProfile', "-Command & {New-Item -ItemType SymbolicLink -Path $resolvedPath -Name $Name -Value $resolvedValue}"
    }
    else {
        New-Item -ItemType SymbolicLink -Path $resolvedPath -Name $Name -Value $resolvedValue
    }
}

function Remove-DirectoryQuickly {
    <#

        Remove-DirectoryQuickly

        ECHO Delete Folder: %CD%?
        PAUSE
        SET FOLDER=%CD%
        CD /
        DEL /F/Q/S "%FOLDER%" > NUL
        RMDIR /Q/S "%FOLDER%"
        EXIT
    #>

    param (
        [Parameter(Mandatory = $false, Position = 0)]
        [string]$DirectoryPath
    )

    $delCmd = 'DEL /F/Q/S "{0}" > NUL'
    $rmdirCmd = 'RMDIR /Q/S "{0}"'

    try {

        if (-not ($DirectoryPath) ) {
            $DirectoryPath = (Get-Location)
        }

        if ((Test-Path $DirectoryPath)) {
            $toDelete = Resolve-Path $DirectoryPath
        }
        else {
            throw "Unable to resolve path: $DirectoryPath"
        }

        if ((Read-Host "Are you SURE you want to PERMANENTLY delete folder and all its children?`n> $toDelete`n[Y]es or [N]o").StartsWith('Y') ) {

            $output = & cmd.exe /c ($delCmd -f $toDelete) 2>&1
            foreach ($line in $output) {
                if ($line -is [System.Management.Automation.ErrorRecord]) {
                    Write-Error $line
                }
                else {
                    Write-Output $line
                }
            }

            $output = & cmd.exe /c ($rmdirCmd -f $toDelete) 2>&1
            foreach ($line in $output) {
                if ($line -is [System.Management.Automation.ErrorRecord]) {
                    Write-Error $line
                }
                else {
                    Write-Output $line
                }
            }
        }
    }
    catch {
        throw
    }
    finally {
        # Done
    }
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
