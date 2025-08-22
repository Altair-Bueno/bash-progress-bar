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

declare -g MESSAGES_ITER=0

function draw-screen {
    # Clear the screen
    printf "\033[H\033[J"

    # Print at most $height - 1 messages
    local height width
    read -r height width <<<"$(stty size)"

    local start=$(( MESSAGES_ITER - height - 1 ))

    [[ "$start" -lt 0 ]] && start=0

    printf "%s\n" "${MESSAGES[@]:$start:$(( MESSAGES_ITER - start ))}"

    # Add the progress bar
    progress-bar -c "$MESSAGES_ITER" -t "${#MESSAGES[@]}" -p -z $'\e[0;31m'
}


# Set a signal handler to redraw if the scren size changes
trap draw-screen SIGWINCH

for (( MESSAGES_ITER=0 ; MESSAGES_ITER <= ${#MESSAGES[@]} ; MESSAGES_ITER++ )); do
    sleep 0.2
    draw-screen
done

# Cleanup
trap - SIGWINCH

# Add a new line to keep the progress bar on screen
echo
