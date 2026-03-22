# 🐚 bash-rpm-installed

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/bash-v3.1+-blue.svg)](https://www.gnu.org/software/bash/)

A Bash shell script to **list and analyze RPM packages** by installation date, with file-based caching for fast repeated queries and formatted output.

> 🚀 **Ever wondered what packages you installed last week?** Or need to audit recent system changes? This tool makes it effortless with a clean, formatted display.

---

## ✨ Features

- **⚡ Fast** - File-based caching for instant repeated queries after the first run
- **📅 Date-Aware** - Filter packages by any date range or use convenient shortcuts
- **📊 Analytics** - Built-in aggregation to see installation patterns (per-day/per-week)
- **🎨 Formatted Output** - Headers, icons, and package counts
- **🎯 Simple** - No additional dependencies beyond standard RPM system tools
- **🔍 Smart** - Auto-detects RPM systems and uses consistent locale parsing
- **📦 Portable** - Can be sourced or executed directly

Perfect for system administrators, power users, and anyone managing RPM-based distributions like **Fedora**, **RHEL**, **CentOS**, **Rocky Linux**, **AlmaLinux**, and **openSUSE**.

---

## 📦 Installation

### Using the Install Script (Recommended)

```bash
# Clone the repository
git clone https://github.com/fdel-ux64/bash-rpm-installed.git
cd bash-rpm-installed

# Run the installer
./install.sh
```

This will:
- Install the script to `~/.local/bin/rpm-installed`
- Install Bash completions to `~/.local/share/bash-completion/completions/`
- Add `~/.local/bin` to your PATH if needed

### Manual Installation

```bash
# Copy the script to a directory in your PATH
cp bin/rpm-installed ~/.local/bin/
chmod +x ~/.local/bin/rpm-installed

# Optional: Install completions
mkdir -p ~/.local/share/bash-completion/completions/
cp completions/rpm-installed.bash ~/.local/share/bash-completion/completions/rpm-installed
```

---

## 🎯 Quick Start

```bash
# What did I install today?
rpm-installed today

# Show packages from last week
rpm-installed last-week

# Count installations this month
rpm-installed count this-month

# Custom date range
rpm-installed since 2025-01-01 until 2025-01-10

# See installation patterns
rpm-installed per-day
```

---

## 🎨 Example Output

```
     📦 List of installed package(s): today
     ╰─────────────────────────────────────────────────────────

 2026-01-18 07:25:05: pipewire-pulseaudio-1.4.10-1.fc43.x86_64
 2026-01-18 07:25:05: pipewire-plugin-libcamera-1.4.10-1.fc43.x86_64
 2026-01-18 07:25:04: wireplumber-0.5.7-1.fc43.x86_64

 ────────────────────────────────────
 🔢 Total number of package(s): 3
```

---

## 📖 Usage

### Basic Syntax

```bash
rpm-installed [OPTION]
rpm-installed count [OPTION]
rpm-installed since DATE [until DATE]
rpm-installed --refresh
rpm-installed --help
```

### Time-Based Shortcuts

| Shortcut | Alias | Description |
|----------|-------|-------------|
| `today` | `td` | Packages installed today |
| `yesterday` | `yd` | Packages installed yesterday |
| `last-week` | `lw` | Last 7 days |
| `this-month` | `tm` | Current calendar month |
| `last-month` | `lm` | Previous calendar month |

### Analytics Options

| Option | Description |
|--------|-------------|
| `per-day` | Count packages grouped by day |
| `per-week` | Count packages grouped by week |

### Special Flags

| Flag | Description |
|------|-------------|
| `--refresh` | Rebuild the cache from scratch |
| `--help` | Show usage information |

---

## 💡 Examples

### Simple Queries with Formatted Output

```bash
# Using shortcuts - shows header, packages, and count
rpm-installed td                    # Today's installations
rpm-installed yd                    # Yesterday's installations
rpm-installed lw                    # Last week

# Aliases also work with count
rpm-installed count td              # Count today's installations
rpm-installed count lw              # Count last week's installations

# With counts (no formatting, just statistics)
rpm-installed count today           # How many packages today?
rpm-installed count last-month      # Monthly installation count
```

### Date Range Queries

```bash
# Specific date range with formatted output
rpm-installed since 2025-12-01 until 2025-12-15

# Open-ended (everything since a date)
rpm-installed since 2025-01-01

# until-only (everything up to a date)
rpm-installed until 2025-06-01

# A single specific day (until is inclusive of the specified date)
rpm-installed since 2025-12-25 until 2025-12-25
```

### Analytics (Statistics Only)

```bash
# Daily installation pattern
rpm-installed per-day

# Output example:
# 2025-01-15  5
# 2025-01-16  12
# 2025-01-17  3

# Weekly trends
rpm-installed per-week

# Output example:
# 2025-W02  18
# 2025-W03  25
```

### Cache Management

```bash
# Refresh the cache after installing packages mid-session
rpm-installed --refresh
```

---

## 🏗️ How It Works

1. **First Run**: Queries all installed RPM packages with installation dates using `rpm -qa`
2. **Caching**: Stores results in `${XDG_CACHE_HOME:-~/.cache}/rpm_installed_cache` for fast subsequent queries — XDG base directory is respected
3. **Locale Handling**: Forces US English locale (`LC_ALL=en_US.UTF-8`) for consistent date parsing across systems
4. **Smart Filtering**: Uses `awk` for efficient date-based filtering
5. **Formatted Display**: Outputs headers, icons, and package counts for readability

### ⚠️ Cache Behavior

The cache is stored on disk and persists across shell sessions. If you install or remove packages during a session, results will not reflect those changes until you run `rpm-installed --refresh`. This is intentional — automatic invalidation behavior may vary by distro in a future release.

The cache write is atomic (via a temp file + `mv`) to prevent corruption if two terminals hit a cold cache simultaneously.

---

## 🎨 Output Formatting

The script provides two types of output:

### **Formatted Display** (default for package listings)
- 📦 Section header with descriptive title
- Clean underline separator
- Package list with timestamps
- 🔢 Total package count footer

### **Statistics Mode** (count/per-day/per-week)
- Plain text output for easy parsing
- No formatting, just data
- Perfect for scripting and analysis

---

## 🔧 Requirements

- **Bash** v3.1 or later
- **RPM-based system** (Fedora, RHEL, CentOS, Rocky Linux, AlmaLinux, openSUSE, etc.)
- Standard system tools: `rpm`, `awk`, `date`, `sort`

---

## 🔄 Uninstallation

```bash
cd bash-rpm-installed
./uninstall.sh
```

This will remove the script and completions from your system.

---

## 📁 Project Structure

```
bash-rpm-installed/
├── bin/
│   └── rpm-installed         # Main script
├── completions/
│   └── rpm-installed.bash    # Bash completion support
├── install.sh                # Installation script
├── uninstall.sh              # Uninstallation script
├── LICENSE                   # MIT License
└── README.md                 # This file
```

---

## 🆕 Changelog

**v2.1.0 – Bug Fixes**
- 🐛 Fixed `until`-only queries being silently ignored (only worked when paired with `since`)
- 🐛 Fixed `until DATE` off-by-one: specified date is now inclusive
- 🐛 Fixed `last-week` and `this-month` having no upper time bound (future-dated packages could appear)
- 🐛 Fixed `count per-day` and `count per-week` silently ignoring the `count` prefix
- 🐛 Fixed alias shortcuts (e.g. `count td`) not resolving after `count` mode shift
- 🐛 Fixed `CACHE_FILE` global variable pollution when script is sourced — now scoped and namespaced
- 🐛 Fixed cache race condition — atomic write via `mktemp` + `mv`
- 🐛 Fixed `local var=$(cmd)` pattern throughout — `local` swallowed exit codes, date failures were silent
- 🐛 Fixed missing bounds check when `since` or `until` is used without a following date argument
- 🐛 Fixed nested function definitions leaking to global scope on every call
- 🐛 Replaced `mapfile` with portable `while IFS= read -r` loop — no longer requires bash 4+
- 🐛 Removed leading space from `rpm --qf` format string

**v2.0.2 – Case-Insensitive Arguments & Consistency**
- ✨ Added case-insensitive argument handling (TODAY, today, Today all work)
- 🔧 Normalized all command arguments and keywords (count, since, until)
- 🐛 Fixed argument parsing to match Fish shell function behavior
- ⚙️ Improved consistency between Bash and Fish implementations

**v2.0.1 – Bug Fix & Help Doc Update**
- 🐛 Fixed help function EOF indentation to prevent parsing errors
- 🐛 Corrected today/yesterday package count to display actual installed packages
- ⚙️ Minor improvements in alias handling and caching

**v2.0 – Enhanced Visual Output**
- ✨ Added formatted headers with package icon (📦)
- ✨ Added total package count footer with counter icon (🔢)
- ✨ Clean underline separators for better readability
- ✨ Applied formatting to all time period options
- ✨ Maintained statistics mode for data analysis
- ✨ Improved distro detection with clear error messages
- ✨ Added LC_ALL locale handling for consistent date parsing

**v1.0.0 – Initial Release**
- 🚀 Initial release of `rpm-installed` to list installed RPM packages by install date
- 📦 Supports filtering by today, yesterday, last week, this month, last month
- ⚙️ Includes count/stats mode and alias shortcuts (td, yd, lw, tm, lm)

---

## 🔗 Related Projects

- [fish-rpm-installed](https://github.com/fdel-ux64/fish-rpm-installed) - Fish shell version of this tool — keep versions in sync, both share the same fix history
- [fish-config](https://github.com/fdel-ux64/fish-config) - Full Fish configuration with multiple utilities

---

## ⚠️ Known Limitations

- Cache persists on disk and must be manually refreshed with `--refresh` after mid-session package changes
- `date -d` requires GNU date — standard on Linux, not available on macOS or BSD without `coreutils`
- Cache invalidation strategy may differ between distros in a future release

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

Created for the Bash shell community and RPM-based distribution users who want better visibility into their system's package history.

---

## ⭐ Show Your Support

If you find this useful, please consider:
- ⭐ Starring this repository
- 🐛 Reporting issues you encounter
- 📢 Sharing it with others who might benefit

---

**Made with 🐚 and ❤️ for the Bash shell community**
