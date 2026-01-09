# Bash completion for rpm-installed

_rpm_installed() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Main options
    opts="today yesterday last-week this-month last-month td yd lw tm lm count stats per-day per-week since until --refresh --help -h"

    # Complete based on previous word
    case "${prev}" in
        rpm-installed)
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
            ;;
        count|stats)
            COMPREPLY=( $(compgen -W "today yesterday last-week this-month last-month per-day per-week since" -- ${cur}) )
            return 0
            ;;
        since|until)
            # Suggest common date formats
            COMPREPLY=( $(compgen -W "today yesterday" -- ${cur}) )
            return 0
            ;;
        *)
            ;;
    esac

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _rpm_installed rpm-installed
