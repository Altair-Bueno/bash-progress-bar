#!/usr/bin/env bash

source "$(dirname "$BASH_SOURCE")/../progress-bar.bash"

# Some messages to print. These could be a message log for a program or similar
declare -ga MESSAGES=(
    "Hacking NASA..."
    "Bypassing firewalls..."
    "Downloading source code..."
    "Injecting shellcode..."
    "Escalating privileges..."
    "Finding admin password..."
    "Encrypting traffic..."
    "Contacting command center..."
    "Tracing IP address..."
    "Deploying exploits..."
    "Brute-forcing credentials..."
    "Uploading payload..."
    "Covering tracks..."
    "Compiling malware..."
    "Scanning open ports..."
    "Running diagnostics..."
    "Disabling security cameras..."
    "Cracking encryption..."
    "Hijacking satellites..."
    "Injecting SQL..."
    "Stealing cookies..."
    "Spoofing MAC address..."
    "Accessing mainframe..."
    "Crossing the event horizon..."
    "Disabling antivirus..."
    "Executing zero-day..."
    "Exfiltrating data..."
    "Overclocking CPU..."
    "Decrypting passwords..."
    "Wiping logs..."
    "Backdooring system..."
    "Simulating AI takeover..."
    "Mining Bitcoin..."
    "Activating Skynet..."
    "Deploying quantum algorithm..."
    "Converting coffee to code..."
    "Stealing WiFi..."
    "Editing registry..."
    "Launching nukes..."
    "Downloading more RAM..."
    "Overwriting BIOS..."
    "Contacting aliens..."
    "Patching kernel..."
    "Injecting DLL..."
    "Scanning darknet..."
    "Planting trojan..."
    "Enabling rootkit..."
    "Running sudo rm -rf / ..."
    "Messing with reality..."
)

STEP=0
TOTAL=${#MESSAGES[@]}

function on-exit {
    deinit-term
}

function on-resize {
    draw-progress-bar
}

function init-term {
    local lines
    lines="$(tput lines)"
    # 1. Ensure at least we have one line for the progress bar
    # 2. Save the current cursor position
    # 3. Set the scrollable region (margin) to exclude the last line
    # 4. Restore the cursor position
    # 5. Move the cursor up one line to be ready to draw the progress bar
    # 6. Add a pulsating OSC progress bar (https://gist.github.com/mitchellh/73777dc99c3ba6d3393690d01a6bd93a)
    # 7. Disable line wrapping to avoid artifacts when resizing
    printf '\n\e7\e[%d;%dr\e8\e[1A\x1b]9;4;3\x07\e[?7l' 0 "$((lines - 1))"
}

function deinit-term {
    local lines
    lines="$(tput lines)"
    # 1. Save the cursor location
    # 2. Reset the scrollable region (margin) to the full terminal
    # 3. Move cursor to the bottom line
    # 4. Clear the line
    # 5. Reset the cursor location
    # 6. Remove OSC progress bar (https://gist.github.com/mitchellh/73777dc99c3ba6d3393690d01a6bd93a)
    # 7. Re-enable line wrapping
    printf '\e7\e[%d;%dr\e[%d;%dH\e[0K\e8\x1b]9;4;0\x07\e[?7h' 0 "$lines" "$lines" 0
}

function draw-progress-bar {
    local lines
    lines="$(tput lines)"
    # 1. Save the cursor location
    # 2. Move cursor to the bottom line
    # 3. Clear the line
    # 4. Print the progress bar
    # 5. Restore the cursor location
    # 6. Update the OSC progress bar (https://gist.github.com/mitchellh/73777dc99c3ba6d3393690d01a6bd93a)
    printf '\e7\e[%d;%dH\e[0K\e[0K%s\e8\x1b]9;4;1;%d\x07' "$lines" 0 "$(progress-bar -c "$STEP" -t "$TOTAL" -w "$(tput cols)" -p)" "$(( 100 * STEP / TOTAL ))"
}


trap on-exit EXIT
init-term
trap on-resize WINCH

echo "Starting hacker software..."
sleep 5
while [[ "$STEP" -le "$TOTAL" ]]; do
    printf '%s\n' "${MESSAGES[$STEP]}"
    draw-progress-bar
    STEP=$(( STEP + 1 ))
    sleep 0.1
done
