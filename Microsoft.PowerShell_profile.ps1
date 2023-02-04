function Prompt {
    $principal = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    if ($principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        $role = 'Admin'
    } else {
        $role = 'User'
    }
    '[{0}] {1} > ' -f $role, ((Get-Location).Path -split '::')[-1]
}

function Open-Administrator {
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

Set-Alias su Open-Administrator
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
