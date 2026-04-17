# Bash Backup Automation

Automated backup script with rotation and logging on Ubuntu Linux.
Backs up files, compresses them, and keeps only the last 7 backups.

## Environment
- OS: Ubuntu 22.04 on WSL2
- Shell: Bash
- Date: April 2026

## Scripts

### backup.sh
Creates compressed backups with timestamp, rotates old backups automatically.

**Usage:**
```bash
./scripts/backup.sh
```

**What it does:**
- Checks source folder exists before backing up
- Creates compressed .tar.gz backup with timestamp
- Keeps only last 7 backups — deletes older ones automatically
- Logs every backup and rotation with timestamp

**Sample output:**# Bash Backup Automation
Backup Started: 2026-04-17_16-27-28
Backing up: source-files
Backup created: backups/backup_2026-04-17_16-27-28.tar.gz (4.0K)
Total backups: 8
Removing old backups - keeping last 7

## Key Commands Used

| Command | What it does |
|---|---|
| tar -czf file.tar.gz folder/ | Create compressed backup |
| tar -xzf file.tar.gz | Extract a backup |
| du -sh file | Show file size |
| ls -t | List files sorted by newest first |
| ls -lh | List files with sizes |
| tail -n +8 | Skip first 7 lines — get everything after |
| xargs rm -f | Delete files passed from previous command |
| wc -l | Count number of files |
| 2>/dev/null | Hide error messages |

## How Rotation Works
Run 1-7:  Creates backups normally
Run 8:    Creates new backup — deletes oldest — keeps 7
Run 9:    Creates new backup — deletes oldest — keeps 7


Always exactly 7 backups on disk — no more, no less.

## Log File
- logs/backup.log — records every backup and rotation with timestamp

## Skills Demonstrated
- Bash scripting with error handling
- File compression with tar
- Automatic backup rotation
- Log management with timestamps
- Conditional logic and counting files
- Git version control and GitHub

- <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5d066206-7d6d-462e-bc4a-10d566e3475d" />

