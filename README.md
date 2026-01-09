# bash-rpm-installed

List installed RPM packages by install date with caching and filtering capabilities.

## Features

- 🚀 Fast caching mechanism for quick queries
- 📅 Filter by time periods (today, yesterday, last week, etc.)
- 📊 Count packages per day/week
- 🎯 Custom date ranges with `since` and `until`
- ⚡ Short aliases (td, yd, lw, tm, lm)
- 🔄 Easy cache refresh

## Installation

### Quick Install (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/YOURUSERNAME/bash-rpm-installed/main/install.sh | bash
```

Or clone and install manually:
```bash
git clone https://github.com/YOURUSERNAME/bash-rpm-installed.git
cd bash-rpm-installed
./install.sh
```

### Requirements

- RPM-based system (Fedora, RHEL, CentOS, openSUSE, etc.)
- Bash 4.0+
- Standard utilities: `awk`, `date`, `sort`

## Usage

### Basic Commands
```bash
# List all installed packages (sorted by install date)
rpm-installed

# Packages installed today
rpm-installed today
rpm-installed td        # short alias

# Packages installed yesterday
rpm-installed yesterday
rpm-installed yd        # short alias

# Last 7 days
rpm-installed last-week
rpm-installed lw        # short alias

# This calendar month
rpm-installed this-month
rpm-installed tm        # short alias

# Last calendar month
rpm-installed last-month
rpm-installed lm        # short alias
```

### Custom Date Ranges
```bash
# Since a specific date
rpm-installed since 2024-01-01

# Between two dates
rpm-installed since 2024-01-01 until 2024-12-31

# Using relative dates
rpm-installed since "3 days ago"
rpm-installed since "last monday" until today
```

### Counting & Statistics
```bash
# Count packages installed today
rpm-installed count today

# Count per day for the last week
rpm-installed count last-week

# Count packages per day (all time)
rpm-installed count per-day

# Count packages per week (all time)
rpm-installed count per-week

# Count for custom range
rpm-installed count since 2024-01-01 until 2024-12-31
```

### Cache Management
```bash
# Refresh the cache (rebuild from RPM database)
rpm-installed --refresh

# Show help
rpm-installed --help
```

## Output Format
```
1704067200 (Mon Jan  1 00:00:00 2024): package-name-1.0.0-1.fc39.x86_64
1704153600 (Tue Jan  2 00:00:00 2024): another-package-2.1.0-1.fc39.x86_64
```
Count output:
```
2024-01-01  15
2024-01-02  8
2024-01-03  23
```
## Examples
```bash
# What did I install today?
rpm-installed td

# How many packages did I install each day this week?
rpm-installed count lw

# Show packages installed in December 2024
rpm-installed since 2024-12-01 until 2025-01-01

# Installation trends
rpm-installed count per-week | tail -20
```

## Uninstall
```bash
curl -sSL https://raw.githubusercontent.com/YOURUSERNAME/bash-rpm-installed/main/uninstall.sh | bash
```

Or from the cloned repository:
```bash
./uninstall.sh
```

## Related Projects

- [fish-rpm-installed](https://github.com/fdel-ux64/fish-rpm-installed) - Fish shell version

## License

MIT License - see [LICENSE](LICENSE) file for details
