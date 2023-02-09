function Prompt {
    '[{0}] {1} > ' -f (Get-Role), ((Get-Location).Path -split '::')[-1]
}

function Get-Role {
    $principal = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        'Admin'
    } else {
        'User'
    }
}

function Start-Administrator {
    Start-Process powershell.exe -Verb RunAs
}

function Edit-Hosts {
    Start-Process `
        -FilePath wsl.exe `
        -ArgumentList 'vim /mnt/c/Windows/System32/drivers/etc/hosts' `
        -Verb RunAs
}

function Get-EnvironmentVariables {
    [Environment]::GetEnvironmentVariables().GetEnumerator() | Sort-Object -Property Key
}

function Edit-EnvironmentVariables {
    Start-Process `
        -FilePath rundll32.exe `
        -ArgumentList 'sysdm.cpl,EditEnvironmentVariables' `
        -Verb RunAs
}

Set-Alias su Start-Administrator
Set-Alias hosts Edit-Hosts
Set-Alias env Edit-EnvironmentVariables

Set-PSReadlineKeyHandler -Chord Alt+b -Function BackwardWord
Set-PSReadlineKeyHandler -Chord Alt+d -Function KillWord
Set-PSReadlineKeyHandler -Chord Alt+f -Function ForwardWord
Set-PSReadlineKeyHandler -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadlineKeyHandler -Chord Ctrl+d -Function DeleteCharOrExit
Set-PSReadlineKeyHandler -Chord Ctrl+e -Function EndOfLine
Set-PSReadlineKeyHandler -Chord Ctrl+k -Function KillLine
Set-PSReadlineKeyHandler -Chord Ctrl+u -Function BackwardKillLine
Set-PSReadlineKeyHandler -Chord Ctrl+w -Function BackwardKillWord
Set-PSReadlineKeyHandler -Chord Ctrl+Insert -Function Copy
Set-PSReadLineKeyHandler -Chord Tab -Function Complete

if (Test-Path -Path 'C:\Program Files (x86)\gsudo\gsudoModule.psd1') {
    Import-Module 'C:\Program Files (x86)\gsudo\gsudoModule.psd1'
}
