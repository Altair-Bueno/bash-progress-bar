# Bash Progress Bar

A customizable, minimal, and mostly pure Bash progress bar for your terminal scripts.

This repository provides a reusable Bash function to display a progress bar in your terminal, making it easy to visualize the progress of long-running shell scripts or loops. The progress bar is highly configurable, supports terminal resizing, and can be easily integrated into your own Bash scripts.

[![asciicast](https://asciinema.org/a/YFESkDLupPlC32ZkebTpKvJaF.svg)](https://asciinema.org/a/YFESkDLupPlC32ZkebTpKvJaF)

## Features

- Pure Bash implementation (no dependencies)
- Customizable bar characters, colors, and decorations
- Supports dynamic terminal width
- Optional percentage display
- Easy to integrate and use in any Bash script

## Usage

Source the `progress-bar.bash` script in your Bash script:

```bash
source path/to/progress-bar.bash
```

Then call the `progress-bar` function:

```man
Usage: progress-bar -c <step> -t <total> [-S <bar_start>] [-E <bar_end>] [-f <fill_character>] [-e <empty_character>] [-z <fill_prefix>] [-x <fill_suffix>] [-Z <empty_prefix>] [-X <empty_suffix>] [-r] [-p] [-h]

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
    Errors, if any
```

### Example

Here's a minimal example of using the progress bar in a loop:

```bash
source ./progress-bar.bash

total=10
for ((i=1; i<=total; i++)); do
    progress-bar -c "$i" -t "$total" -r
    sleep 0.2
done
echo
```

### Advanced Example

See [`examples/automatic-resize.bash`](examples/automatic-resize.bash) for a more advanced usage example that demonstrates automatic resizing and fun progress messages.

## Customization

You can customize the look and feel of the progress bar using the available options. For example, to use different characters or colors:

```bash
progress-bar -c "$i" -t "$total" -S "{" -E "}" -f "#" -e "." -z $'\e[0;34m' -x $'\e[0m' -p
```
