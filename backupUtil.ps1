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

.PARAMETER MyFilesPath
    Acts as the source or destination where the my folder will be placed.

.EXAMPLE
    BackupUtil -Backup -Path "D:\Backups" -MyFilesPath "E:\myFiles"
 
.EXAMPLE
    BackupUtil -Restore -Path "D:\Backups\Backup_2025-01-15_120000" -MyFilesPath "D:\Users\myuser\myFolder"
#>

#Defining input parameters.
param (

    [Parameter(ParameterSetName = "Backup", Mandatory)]
    [switch]$Backup,

    [Parameter(ParameterSetName= "Restore", Mandatory)]
    [switch]$Restore,

    [Parameter(Mandatory)]
    [string]$Path,

    [Parameter(Mandatory)]
    [string]$MyFilesPath
)

#region backupWinget
#This function creates a backup of winget using the winget export feature.
function backupWinget {
    param (
        [string]$Path
    )

    $wingetBackupPath = Join-Path -Path $Path -ChildPath wingetBackup.json
    winget export -o $wingetBackupPath

    if ($LASTEXITCODE -ne 0) {
        Write-Error "winget export failed with exit code $LASTEXITCODE"
        return
    }
}
#endregion


#region restoreWinget
#This function restores winget apps using a exported winget json file from a backup.
function restoreWinget {
    $wingetRestorePath = Join-Path -Path $Path -ChildPath wingetBackup.json
    winget import -i $wingetRestorePath

    if ($LASTEXITCODE -ne 0) {
        Write-Error "winget import failed with exit code $LASTEXITCODE"
        return
    }
}
#endregion


#region backupAppsList
#This function backs up a list of all non-winget apps as a text file.
function backupAppsList {

}
#endregion

#region backup
#This function creates a backup folder at the inputted folder path.
function backup {
    $datestamp = Get-Date -Format "MM-dd-yyyy"
    $backupPath = Join-Path -Path $Path -ChildPath "Backup_$datestamp"
 
    if (Test-Path $backupPath) {
        Remove-Item -Path $backupPath -Recurse -Force
    }

    New-Item -Path $backupPath -ItemType Directory

    backupWinget -Path $backupPath

    $myFilesBackupPath = Join-Path -Path $backupPath -ChildPath "myFiles.zip"
    Compress-Archive -Path $MyFilesPath -DestinationPath $myFilesBackupPath -CompressionLevel Optimal
}
#endregion

#region restore
#This function restores a backup from the inputted folder path.
function restore {
    if (Test-Path $Path) {
        restoreWinget

        $myFileBackupPath = Join-Path -Path $Path -ChildPath "myFiles.zip"
        Expand-Archive -Path $myFileBackupPath -DestinationPath $MyFilesPath

        [System.Environment]::SetEnvironmentVariable(
            "PATH",
            $env:PATH + ";$MyFilesPath\scripts",
            [System.EnvironmentVariableTarget]::User
        )
    } else {
        Write-Error "No backup folder found."
        return
    }
}
#endregion

#region Main
if ($Backup) {
    backup
} elseif ($Restore) {
    restore
}
Write-Output "END OF PROGRAM"
#endregion