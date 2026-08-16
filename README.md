# bash-rpm-installed

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/bash-v3.1+-blue.svg)](https://www.gnu.org/software/bash/)

A Bash shell script to list and analyze RPM packages by installation date, with file-based caching for fast repeated queries and formatted output.

---

## Features

File-based caching makes repeated queries instant after the first run. Packages are grouped by installation date with per-group counts, and there's built-in aggregation for installation patterns (per-day/per-week). Package search looks up the full install history of any package by exact name or glob pattern (`kern*`, `*lib*`). No additional dependencies beyond standard RPM system tools, and the script can be sourced or executed directly.

Useful for Fedora, RHEL, CentOS, Rocky Linux, AlmaLinux, openSUSE, and other RPM-based distributions.

---

## Installation

### Using the Install Script

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

## Quick Start

```bash
# What did I install today?
rpm-installed today

# Show packages from the last 3 days
rpm-installed days 3

# Show packages from last week
rpm-installed last-week

# Count installations this month
rpm-installed count this-month

# Custom date range
rpm-installed since 2025-01-01 until 2025-01-10

# Exact single date
rpm-installed on 2026-05-15

# Packages installed this calendar week
rpm-installed this-week

# See installation patterns
rpm-installed per-day

# Look up a package's full install history
rpm-installed package cups

# Look up all kernel packages (no quoting needed in Bash)
rpm-installed package kern*
```

---

## Example Output

```
    📦 Installed packages — last-week

 📆 Wed 2026-03-18  (5 packages)
    onnx-libs-1.17.0-12.fc43.x86_64
    zlib-ng-2.3.3-2.fc43.x86_64
    zlib-ng-compat-2.3.3-2.fc43.x86_64
    zlib-ng-compat-devel-2.3.3-2.fc43.x86_64
    perl-Module-CoreList-5.20260308-1.fc43.noarch
 📆 Thu 2026-03-19  (3 packages)
    firefox-148.0.2-2.fc43.x86_64
    firefox-langpacks-148.0.2-2.fc43.x86_64
    libtasn1-4.21.0-1.fc43.x86_64

 ────────────────────────────────────
 🔢 Total: 8 packages — last-week
 💾 Cache: file cache
```

The filter label is always repeated in the footer, so context is preserved without having to scroll back up.

When output exceeds the terminal height, the list is automatically paged with `less` — scroll freely, press `q` to exit. Paging is skipped when output is piped so scripting is unaffected.

### Package Search Output

```
    📦 Package history — kern*

 📆 Sat 2026-05-09  (5 packages)
    09:30 CEST  kernel-core-7.0.4-200.fc44.x86_64
    09:30 CEST  kernel-modules-core-7.0.4-200.fc44.x86_64
    09:30 CEST  kernel-modules-7.0.4-200.fc44.x86_64
    09:30 CEST  kernel-modules-extra-7.0.4-200.fc44.x86_64
    09:30 CEST  kernel-7.0.4-200.fc44.x86_64
 📆 Thu 2026-05-14  (6 packages)
    10:50 CEST  kernel-core-7.0.6-200.fc44.x86_64
    10:50 CEST  kernel-modules-7.0.6-200.fc44.x86_64
    10:50 CEST  kernel-7.0.6-200.fc44.x86_64
    ...

 ────────────────────────────────────
 🔢 11 install records matching 'kern*'
 💾 Cache: file cache
```

Package search groups results by date and shows install time to the minute. All kernel update cycles are visible at a glance.

---

## Usage

### Basic Syntax

```bash
rpm-installed [OPTION]
rpm-installed days N
rpm-installed on DATE
rpm-installed count [OPTION]
rpm-installed since DATE [until DATE]
rpm-installed package NAME
rpm-installed package PATTERN
rpm-installed --refresh
rpm-installed --help
```

### Time-Based Shortcuts

| Shortcut     | Alias | Description                                  |
| ------------ | ----- | -------------------------------------------- |
| `today`      | `td`  | Packages installed today                     |
| `yesterday`  | `yd`  | Packages installed yesterday                 |
| `days N`     |       | Last N days, rolling window (today included) |
| `on DATE`    |       | Exact single date — e.g. `on 2026-05-15`     |
| `this-week`  | `tw`  | This calendar week, Mon → today              |
| `last-week`  | `lw`  | Last 7 days                                  |
| `this-month` | `tm`  | Current calendar month                       |
| `last-month` | `lm`  | Previous calendar month                      |

### Package Search

| Syntax            | Description                                            |
| ----------------- | ------------------------------------------------------ |
| `package NAME`    | Full install history for an exact package name         |
| `package PATTERN` | Full install history with glob — e.g. `kern*`, `*lib*` |

Unlike the Fish shell version, glob patterns don't need quoting in Bash, `rpm-installed package kern*` works as-is.

### Analytics Options

| Option     | Description                    |
| ---------- | ------------------------------ |
| `per-day`  | Count packages grouped by day  |
| `per-week` | Count packages grouped by week |

### Special Flags

| Flag        | Description                              |
| ----------- | ---------------------------------------- |
| `--refresh` | Clear and rebuild the cache on next call |
| `--help`    | Show usage information                   |

---

## Examples

### Simple Queries with Formatted Output

```bash
# Using shortcuts - shows grouped output with date headers and count
rpm-installed td                    # Today's installations
rpm-installed yd                    # Yesterday's installations
rpm-installed tw                    # This calendar week (Mon → today)
rpm-installed lw                    # Last week
rpm-installed days 3                # Last 3 days (rolling window, today included)
rpm-installed days 14               # Last 14 days

# With counts (no formatting, just statistics)
rpm-installed count today           # How many packages today?
rpm-installed count this-week       # How many packages this week?
rpm-installed count days 5          # How many packages in the last 5 days?
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

# Exact single date — cleaner than since X until X
rpm-installed on 2026-05-15

# Count packages on a specific date
rpm-installed count on 2026-05-15

# A single specific day using since/until (equivalent to 'on')
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

### Package Search

```bash
# Exact name — full install history
rpm-installed package cups
rpm-installed package firefox

# Glob pattern — no quoting needed in Bash (unlike Fish shell)
rpm-installed package kern*        # all kernel packages
rpm-installed package 'python3*'   # quoting is fine too, just not required
rpm-installed package '*lib*'      # anything with 'lib' in the name
```

---

## How It Works

1. **First Run**: Queries all installed RPM packages with installation timestamps using `rpm -qa`
2. **Caching**: Stores results in `${XDG_CACHE_HOME:-~/.cache}/rpm_installed_cache` for fast subsequent queries — XDG base directory is respected
3. **Locale Handling**: Forces US English locale (`LC_ALL=en_US.UTF-8`) for consistent date parsing across systems
4. **Smart Filtering**: Uses `awk` for efficient date-based filtering
5. **Grouped Display**: Packages are grouped by installation date — 📆 date headers with per-group counts make long lists easy to scan

### Cache Behavior

The cache is stored on disk and persists across shell sessions. If you install or remove packages during a session, results will not reflect those changes until you run `rpm-installed --refresh`.

The cache write is atomic (via a temp file + `mv`) to prevent corruption if two terminals hit a cold cache simultaneously.

---

## Output Formatting

The script provides two types of output:

### Formatted Display (default for package listings)

- Section header with filter label
- Date group headers with per-group package counts
- Clean package name list under each date group
- Total package count footer with filter label always repeated — visible without scrolling up
- Cache status shown in footer (`file cache`)
- Auto-paged with `less` when output exceeds terminal height; skipped when piped

### Package Search Display (`package NAME` / `package PATTERN`)

- Same date-grouped layout as above
- Install time shown to the minute (e.g. `05:30 CEST`) — useful for spotting batch updates
- Footer shows match count and the pattern used

### Statistics Mode (count/per-day/per-week)

- Plain text output for easy parsing
- No formatting, just data
- Perfect for scripting and analysis

---

## Requirements

- **Bash** v3.1 or later
- **RPM-based system** (Fedora, RHEL, CentOS, Rocky Linux, AlmaLinux, openSUSE, etc.)
- Standard system tools: `rpm`, `awk`, `date`, `sort`

---

## Uninstallation

```bash
cd bash-rpm-installed
./uninstall.sh
```

This will remove the script and completions from your system.

---

## Project Structure

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

## Changelog

**v3.5.0 – this-week subcommand**

- Added `this-week` (alias `tw`): ISO calendar week from Monday 00:00 through end of today
- Heading shows explicit date range: `Mon 2026-05-25 → Thu 2026-05-28`
- Works in count mode: `count this-week`
- Ported from fish-rpm-installed v3.5 — in sync

**v3.4.0 – on DATE subcommand & heading fix**

- Added `on DATE` subcommand: exact single-date query — cleaner than `since DATE until DATE`
- Works in count mode: `count on DATE`
- Fixed `since X until X` footer heading showing the next day (e.g. `until 2026-05-16` when `until 2026-05-15` was typed)
- Ported from fish-rpm-installed v3.4 — in sync

**v3.3.0 – Package Search**

- Added `package NAME` subcommand: full install history for an exact package name
- Added glob support: `package PATTERN` matches with `*`, `?` (e.g. `kern*`, `*lib*`)
- Package search output shows install time to the minute, grouped by date
- Ported from fish-rpm-installed v3.3 — in sync

**v3.2.0 – Future-Timestamp Warning & Bug Fixes**

- Detect and warn on future-dated RPM INSTALLTIME entries (NTP clock correction during transaction)
- Fixed `count per-day` and `count per-week` erroring when prefixed with `count`

**v3.1.0 – Cache Status in Footer**

- Cache status now shown in footer on every listing (`💾 Cache: file cache`)

**v3.0.0 – Auto-Pager & Days Range**

- Added `days N` subcommand: rolling window from N days ago 00:00 through end of today
- Works in count mode: `rpm-installed count days 5`
- Auto-page with `less -R` when output exceeds terminal height — scroll freely, `q` to exit
- Pager skipped when stdout is piped — scripting unaffected
- Filter label now always shown in footer — context visible without scrolling up
- Removed conditional threshold footer (`RPM_SUMMARY_THRESHOLD`) — superseded by pager

**v2.5.0 – Grouped Output & Updated Threshold**

- Packages now grouped by installation date with 📆 date headers and per-group counts
- Redundant timestamp removed from each package line — cleaner, easier to scan
- `--refresh` description clarified: clears the cache, caching stays enabled
- Summary threshold raised from 25 to 100 (`RPM_SUMMARY_THRESHOLD`)
- Updated footer format: `🔢 Total: N packages`

**v2.1.1 – Footer Summary for Long Lists**

- Added filter criteria repeat in footer when package count exceeds threshold
- Threshold controlled by `RPM_SUMMARY_THRESHOLD` variable (default: 25)

**v2.1.0 – Bug Fixes**

- Fixed `until`-only queries being silently ignored (only worked when paired with `since`)
- Fixed `until DATE` off-by-one: specified date is now inclusive
- Fixed `last-week` and `this-month` having no upper time bound (future-dated packages could appear)
- Fixed `count per-day` and `count per-week` silently ignoring the `count` prefix
- Fixed alias shortcuts (e.g. `count td`) not resolving after `count` mode shift
- Fixed `CACHE_FILE` global variable pollution when script is sourced — now scoped and namespaced
- Fixed cache race condition — atomic write via `mktemp` + `mv`
- Fixed `local var=$(cmd)` pattern throughout — `local` swallowed exit codes, date failures were silent
- Fixed missing bounds check when `since` or `until` is used without a following date argument
- Fixed nested function definitions leaking to global scope on every call
- Replaced `mapfile` with portable `while IFS= read -r` loop — no longer requires bash 4+
- Removed leading space from `rpm --qf` format string

**v2.0.2 – Case-Insensitive Arguments & Consistency**

- Added case-insensitive argument handling (TODAY, today, Today all work)
- Normalized all command arguments and keywords (count, since, until)
- Fixed argument parsing to match Fish shell function behavior
- Improved consistency between Bash and Fish implementations

**v2.0.1 – Bug Fix & Help Doc Update**

- Fixed help function EOF indentation to prevent parsing errors
- Corrected today/yesterday package count to display actual installed packages
- Minor improvements in alias handling and caching

**v2.0 – Enhanced Visual Output**

- Added formatted headers with package icon (📦)
- Added total package count footer with counter icon (🔢)
- Clean underline separators for better readability
- Applied formatting to all time period options
- Maintained statistics mode for data analysis
- Improved distro detection with clear error messages
- Added LC_ALL locale handling for consistent date parsing

**v1.0.0 – Initial Release**

- Initial release of `rpm-installed` to list installed RPM packages by install date
- Supports filtering by today, yesterday, last week, this month, last month
- Includes count/stats mode and alias shortcuts (td, yd, lw, tm, lm)

---

## Related Projects

- [fish-rpm-installed](https://github.com/fdel-ux64/fish-rpm-installed) - Fish shell version of this tool — keep versions in sync, both share the same fix history
- [fish-config](https://github.com/fdel-ux64/fish-config) - Full Fish configuration with multiple utilities

## Development

This function is developed as part of [fish-config](https://github.com/fdel-ux64/fish-config).
Feature requests and issues are tracked there.

---

## Known Limitations

- Cache persists on disk and must be manually refreshed with `--refresh` after mid-session package changes
- `date -d` requires GNU date — standard on Linux, not available on macOS or BSD without `coreutils`
- Cache invalidation strategy may differ between distros in a future release

---

## Contributing

Bug reports, feature suggestions, and pull requests are welcome.

---

## License

MIT, see the [LICENSE](LICENSE) file for details.
