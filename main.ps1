# Requires -Version 7.6.1
<#
.SYNOPSIS
    System backup and restore utility for windows.

.DESCRIPTION
    Backs up the names of all installed software, as well as a export of all winget installed
    software. Also can restore all winget installed software via the backup.

.PARAMETER Backup
    Switch to perform a backup. Requires -Path.

.Parameter Restore
    Switch to restore a backup. Requires -Path.

.PARAMETER Path
    Acts as the source for a restore or the destination for a backup.

.EXAMPLE
    BackupUtil -Backup -Path "D:\Backups"
 
.EXAMPLE
    BackupUtil -Restore -Path "D:\Backups\Backup_2025-01-15_120000"
#>

# Defining input parameters.
param (

    [Parameter(ParameterSetName = "Backup", Mandatory)]
    [switch]$Backup,

    [Parameter(ParameterSetName= "Restore", Mandatory)]
    [switch]$Restore,

    [Parameter(Mandatory)]
    [string]$Path
)

# region backupWinget
# This function creates a backup of winget using the winget export feature.
function backupWinget {
    winget export -o $Path

    if ($LASTEXITCODE -ne 0) {
        Write-Error "winget export failed with exit code $LASTEXITCODE"
        return
    }
}
# endregion


# region restoreWinget
# This function restores winget apps using a exported winget json file from a backup.
function restoreWinget {
    
}
# endregion


# region backupAppsList
# This function backs up a list of all non-winget apps as a text file.
function backupAppsList {

}
#endregion

# region backup
# This function creates a backup folder at the inputted folder path.
function backup {
    # Function parameters.
    param(
        [string]$Destination
    )

    $datestamp = Get-Date -Format "MM/dd/yyyy"
    $backupPath = Join-Path -Path $Destination -ChildPath "Backup_$datestamp"
}
# endregion

# region restore
# This function restores a backup from the inputted folder path.
function restore {

}
# endregion

Write-Output "END OF PROGRAM"