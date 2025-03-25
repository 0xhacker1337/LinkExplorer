# Link Explorer 
```bash
 _      _         _     ______               _
| |    (_)       | |    |  ___|             | |
| |     _  _ __  | | __ | |__  __  __ _ __  | |  ___   _ __   ___  _ __
| |    | || '_ \ | |/ / |  __| \ \/ /| '_ \ | | / _ \ | '__| / _ \| '__|
| |____| || | | ||   <  | |___  >  < | |_) || || (_) || |   |  __/| |
\_____/|_||_| |_||_|\_\ \____/ /_/\_\| .__/ |_| \___/ |_|    \___||_|
                                     | |
                                     |_|            ~cybe3king

```

## Description

This script helps gather URLs from various sources using multiple tools. It supports running tools sequentially and allows you to select commands for each tool interactively. The final output is a combined list of URLs with duplicates removed.

## Features

- **Interactive Command Selection:** Choose from multiple commands for each tool.
- **Tool Checks:** Verifies if the necessary tools are installed.
- **Output Management:** Saves results in an output directory and combines them into a final file.
- **Duplicate Removal:** Removes duplicate URLs from the final output.

## Tools Required

- `waymore`
- `gau`
- `gauplus`
- `waybackurls`
- `katana`

## Installation

Clone this repository: git clone https://github.com/0xhacker1337/LinkExplorer
Navigate to files: cd LinkExplorer
Provide Execute Permission: chmod +x linkexplorer.sh
Run LinkExplorer: ./linkexplorer.sh

## Usage

```bash
./linkexplorer -d <domain> -l <list_of_domains> -o <output_file>
```
-  -d <target > | -l <target_list_filename>: The domain or file containing a list of domains to process.
- -o [output_filename]: Optional output file name. If not provided, a default name will be used.

## Example
Run the script with a single domain:
```bash
./linkexplorer.sh -d domain.com -o output.txt
```
Run the script with a list of domains from a file:

```bash
./linkexplorer.sh -l domains.txt
```
Specify an output file:
```bash
./linkexplorer.sh -l domains.txt -o custom_output.txt
```

## Adding/Removing Commands
To add or remove commands for a tool, you can modify the script directly. The ** waymore_commands, gau_commands, gauplus_commands, waybackurls_commands, and katana_commands ** arrays contain the commands for each tool.

## Screenshot

## Contributing
Feel free to contribute by creating issues or submitting pull requests. Ensure you follow the contribution guidelines.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements
- Thank you to the authors of the tools used in this script.
