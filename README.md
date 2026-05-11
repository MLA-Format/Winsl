# Winsl

A PowerShell backup and restore utility for Windows. Backs up a list of installed software and personal files so you can fully restore a machine after a reinstall.

## Requirements

- PowerShell 7.6.1+
- [Winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/)

## What It Backs Up

- **Winget packages** — exported as a `wingetBackup.json` file, ready to bulk-reinstall
- **My Files** — compresses a folder of your choice into `myFiles.zip`

## Usage

### Backup

```powershell
.\Winsl.ps1 -Backup -Path "D:\Backups" -MyFilesPath "C:\Users\You\myFiles"
```

Creates a timestamped folder at the given path (e.g. `D:\Backups\Backup_05-11-2026`) containing your winget export and a zip of your files.

### Restore

```powershell
.\Winsl.ps1 -Restore -Path "D:\Backups\Backup_05-11-2026" -MyFilesPath "C:\Users\You\myFiles"
```

Reinstalls all winget packages from the backup, extracts your files to the given path, and adds a `scripts` subfolder to your user `PATH`.

## Parameters

| Parameter | Description |
|---|---|
| `-Backup` | Run in backup mode |
| `-Restore` | Run in restore mode |
| `-Path` | Destination folder for a backup, or source folder for a restore |
| `-MyFilesPath` | Folder to back up, or destination to restore files to |

## Backup Folder Structure

```
Backup_MM-DD-YYYY/
├── wingetBackup.json
└── myFiles.zip
```
