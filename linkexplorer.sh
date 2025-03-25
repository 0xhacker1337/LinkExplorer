#!/bin/bash

# Banner with colors
echo -e "\e[1;36m
 _      _         _     ______               _
| |    (_)       | |    |  ___|             | |
| |     _  _ __  | | __ | |__  __  __ _ __  | |  ___   _ __   ___  _ __
| |    | || '_ \ | |/ / |  __| \ \/ /| '_ \ | | / _ \ | '__| / _ \| '__|
| |____| || | | ||   <  | |___  >  < | |_) || || (_) || |   |  __/| |
\_____/|_||_| |_||_|\_\ \____/ /_/\_\| .__/ |_| \___/ |_|    \___||_|
                                     | |
                                     |_|            ~0xhacker1337

\e[0m"

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if necessary tools are installed
TOOLS=("waymore" "gau" "gauplus" "waybackurls" "katana")

for tool in "${TOOLS[@]}"; do
  if ! command_exists $tool; then
    echo -e "\e[1;31mError: $tool is not installed. Please install it before running this script.\e[0m"
    exit 1
  fi
done

# Check if target(s) and optional output file are provided
if [ -z "$1" ]; then
  echo -e "\e[1;33mUsage: $0 <target|target_list_file> [output_file]\e[0m"
  exit 1
fi

TARGET=$1
OUTPUT_FILE=$2

# If output file is not provided, derive it from the target
if [ -z "$OUTPUT_FILE" ]; then
  if [[ -f $TARGET ]]; then
    OUTPUT_FILE="${TARGET%.*}_output.txt"
  else
    OUTPUT_FILE="${TARGET}_output.txt"
  fi
fi

OUTPUT_DIR="output"
COMBINED_OUTPUT="$OUTPUT_DIR/combined_output.txt"
FINAL_OUTPUT="$OUTPUT_FILE"
mkdir -p "$OUTPUT_DIR"

# Clear the combined output file if it exists
> "$COMBINED_OUTPUT"

# Function to run a tool with user-selected command
run_tool_with_selection() {
  local tool=$1
  local options=("${@:2}")

  while true; do
    echo -e "\e[1;34mSelect a command for $tool:\e[0m"
    local i=1
    for option in "${options[@]}"; do
      echo "$i. $option"
      ((i++))
    done

    read -p "Enter option number (or 'n' to skip to the next tool): " selected_option

    if [[ $selected_option == 'n' ]]; then
      echo -e "\e[1;33mSkipping $tool.\e[0m"
      return
    fi

    if [[ $selected_option -lt 1 || $selected_option -gt ${#options[@]} ]]; then
      echo -e "\e[1;31mInvalid option. Please try again or enter 'n' to skip.\e[0m"
    else
      local cmd="${options[$((selected_option - 1))]}"
      echo -e "\e[1;32mRunning: $cmd\e[0m"
      eval "$cmd" >> "$OUTPUT_DIR/${tool}_output.txt"
      eval "$cmd" >> "$COMBINED_OUTPUT"
      return
    fi
  done
}

# Define commands for each tool
waymore_commands=(
  "waymore -i $TARGET -mode U -oU $OUTPUT_DIR/waymore_output.txt -url-filename -p 4"
)

gau_commands=(
  "echo $TARGET | gau"
  "cat $TARGET | gau"
)

waybackurls_commands=(
  "echo $TARGET | waybackurls"
  "cat $TARGET | waybackurls"
)

katana_commands=(
  "katana -u $TARGET -o $OUTPUT_DIR/katana_output.txt"
)

gauplus_commands=(
  "echo $TARGET | gauplus"
  "cat $TARGET | gauplus"
)

# Run each tool with user-selected command
run_tool_with_selection "waymore" "${waymore_commands[@]}"
run_tool_with_selection "gau" "${gau_commands[@]}"
run_tool_with_selection "waybackurls" "${waybackurls_commands[@]}"
run_tool_with_selection "katana" "${katana_commands[@]}"
run_tool_with_selection "gauplus" "${gauplus_commands[@]}"

# Remove duplicates and save the final output
echo -e "\e[1;32mRemoving duplicates...\e[0m"
sort -u "$COMBINED_OUTPUT" > "$FINAL_OUTPUT"

echo -e "\e[1;32mScanning completed. Final output saved in $FINAL_OUTPUT\e[0m"
