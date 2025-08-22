PROGRESS_BAR_USAGE_TEMPLATE="Usage: %s -c <step> -t <total> [-S <bar_start>] [-E <bar_end>] [-f <fill_character>] [-e <empty_character>] [-z <fill_prefix>] [-x <fill_suffix>] [-Z <empty_prefix>] [-X <empty_suffix>] [-r] [-p] [-h]

Options:
  -c <step>             Current step (required)
  -t <total>            Total steps (required)
  -S <bar_start>        String to start the bar (default: '[')
  -E <bar_end>          String to end the bar (default: ']')
  -f <fill_character>   Character to use for the filled part of the bar (default: '█')
  -e <empty_character>  Character to use for the empty part of the bar (default: ' ')
  -z <fill_prefix>      Prefix to add before each fill_character (default: '\e[0;32m')
  -x <fill_suffix>      Suffix to add after each fill_character (default: '\e[0m')
  -Z <empty_prefix>     Prefix to add before each empty_character (default: '')
  -X <empty_suffix>     Suffix to add after each empty_character (default: '')
  -r                    Add a carriage return at the end of the bar
  -p                    Show percentage at the end of the bar
  -h                    Show this help message

Enviroment
    COLUMNS           If set, it will be used to determine the terminal width

stdout:
    The progress bar
stderr:
    Errors, if any"

function progress-bar-repeat-string {
    local what="$1" n="$2" i

    for (( i=0 ; i < n ; i++ )); do
        printf "%s" "$what"
    done
}

function progress-bar-get-terminal-width {
    if [[ -n "${COLUMNS:+x}" ]]; then
        printf "%s" "$COLUMNS"
    else
        local height width
        read -r height width <<<"$(stty size)"
        printf "%s" "$width"
    fi
}

function progress-bar {
    local step
    local total

    local bar_width="$(progress-bar-get-terminal-width)"
    local bar_start="["
    local bar_end="]"

    local fill_prefix=$'\e[0;32m'
    local fill_character="█"
    local fill_suffix=$'\e[0m'

    local empty_prefix=""
    local empty_character=" "
    local empty_suffix=""

    local add_carriage_return=""
    local show_percentage=""

    local opt OPTARG OPTIND
    while getopts "c:t:S:E:f:e:z:x:Z:X:rph" opt; do
        case "$opt" in
            c) step="$OPTARG" ;;
            t) total="$OPTARG" ;;
            S) bar_start="$OPTARG" ;;
            E) bar_end="$OPTARG" ;;
            f) fill_character="$OPTARG" ;;
            e) empty_character="$OPTARG" ;;
            z) fill_prefix="$OPTARG" ;;
            x) fill_suffix="$OPTARG" ;;
            Z) empty_prefix="$OPTARG" ;;
            X) empty_suffix="$OPTARG" ;;
            r) add_carriage_return=true ;;
            p) show_percentage=true ;;
            h) printf "$PROGRESS_BAR_USAGE_TEMPLATE" "$0" >&2 ; return 1 ;;
            *) return 1 ;;
        esac
    done

    local percentage="${show_percentage:+$(( 100 * step / total ))%}"

    local bar_start_printable_only="${bar_start//[[!:print:]]/}"
    local bar_start_printable_size="${#bar_start_printable_only}"

    local bar_end_printable_only="${bar_end//[[!:print:]]/}"
    local bar_end_printable_size="${#bar_end_printable_only}"

    local fill_character_printable_only="${fill_character//[[!:print:]]/}"
    local fill_character_printable_size="${#fill_character_printable_only}"

    local empty_character_printable_only="${empty_character//[[!:print:]]/}"
    local empty_character_printable_size="${#empty_character_printable_only}"

    local available_characters=$(( bar_width - bar_start_printable_size - bar_end_printable_size - ${#percentage} ))

    local fill_repeat=$(( ((available_characters * step ) / total) / fill_character_printable_size ))
    local empty_repeat=$(( (available_characters - (fill_repeat * fill_character_printable_size )) / empty_character_printable_size ))

    printf "%s" \
        "${bar_start}" \
        "${fill_prefix}" \
        "$(progress-bar-repeat-string "$fill_character" "$fill_repeat")" \
        "${fill_suffix}" \
        "${empty_prefix}" \
        "$(progress-bar-repeat-string "$empty_character" "$empty_repeat")" \
        "${empty_suffix}" \
        "${bar_end}" \
        "${percentage}" \
        "${add_carriage_return:+$'\r'}"
}
