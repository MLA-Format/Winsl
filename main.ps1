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