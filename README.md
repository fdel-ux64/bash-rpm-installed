# bash-rpm-installed

A Bash script to list installed RPM packages by installation date, 
with caching for faster repeated queries.

This script supports RPM-based distributions such as **Fedora, RHEL, CentOS, and openSUSE**.
It provides fast package querying through an efficient caching mechanism.

---

## ✨ Features

* Distro check for RPM-based systems
* Fast caching mechanism for quick queries
* List installed RPM packages by date range
* Common time-based shortcuts (today, yesterday, last-week, etc.)
* Aggregated statistics (per-day / per-week)
* Custom date ranges with `since` and `until`
* Simple, dependency-free Bash implementation

---

## 📦 Installation

### Quick Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/fdel-ux64/bash-rpm-installed/main/install.sh | bash
```

Or clone and install manually:

```bash
git clone https://github.com/fdel-ux64/bash-rpm-installed.git
cd bash-rpm-installed
./install.sh
```

### Requirements

* RPM-based system (Fedora, RHEL, CentOS, openSUSE, etc.)
* Bash 4.0+
* Standard utilities: `awk`, `date`, `sort`

### Project Structure

```
bash-rpm-installed/
├── bin/
│   └── rpm-installed          # Main executable script
├── completions/
│   └── rpm-installed.bash     # Bash completion script
├── install.sh                 # Installation script
├── uninstall.sh               # Uninstallation script
├── LICENSE                    # License file
└── README.md                  # This file
```

---

## 🚀 Usage

* `rpm-installed [OPTION]`
* `rpm-installed count [OPTION]`
* `rpm-installed since DATE [until DATE]`
* `rpm-installed --refresh`
* `rpm-installed --help`

## Options

| Option | Description |
|--------|-------------|
| `today` | Packages installed today |
| `yesterday` | Packages installed yesterday |
| `last-week` | Packages installed in the last 7 days |
| `this-month` | Packages installed this calendar month |
| `last-month` | Packages installed in the previous month |
| `per-day` | Count packages per day |
| `per-week` | Count packages per week |

## Aliases

| Alias | Expands to |
|-------|------------|
| `td` | today |
| `yd` | yesterday |
| `lw` | last-week |
| `tm` | this-month |
| `lm` | last-month |

---

## 💡 Examples

### Basic Queries

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

---

## 📊 Output Format

Package listing:

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

---

## 📝 Notes

* This tool only works on RPM-based systems.
* The cache can be rebuilt at any time using `--refresh`.
* Designed to be fast, simple, and predictable.
* Cache location: `~/.cache/rpm-installed/packages.cache`

---

## 🗑️ Uninstall

```bash
curl -sSL https://raw.githubusercontent.com/fdel-ux64/bash-rpm-installed/main/uninstall.sh | bash
```

Or from the cloned repository:

```bash
./uninstall.sh
```

---

## 🔗 Related Projects

* [fish-rpm-installed](https://github.com/fdel-ux64/fish-rpm-installed) - Fish shell version

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details
