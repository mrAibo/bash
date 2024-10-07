Here's a GitHub-style documentation for the provided `.bashrc` file:

# Enhanced .bashrc Configuration

This `.bashrc` file provides a comprehensive set of configurations, aliases, and functions to enhance your Bash shell experience. It includes history management, shell options, custom prompts, and various utility functions.

## Table of Contents

1. [History Configuration](#history-configuration)
2. [Shell Options](#shell-options)
3. [Aliases](#aliases)
4. [Functions](#functions)
   - [venv_manager](#venv_manager)
   - [ex (Extract and Compress)](#ex-extract-and-compress)
   - [rcp (Remote Copy)](#rcp-remote-copy)
   - [duu (Enhanced du)](#duu-enhanced-du)
   - [Other Utility Functions](#other-utility-functions)

## History Configuration

- Prevents duplicate lines and commands starting with space from being saved in history
- Sets a large history size (100,000 commands) and file size (2,000,000 lines)
- Ignores certain common commands in history
- Appends to history file immediately after each command
- Adds timestamps to history entries

## Shell Options

- Enables case-insensitive filename completion
- Corrects minor errors in directory spelling
- Combines multiline commands into one history entry
- Updates window size after each command

## Aliases

- `count`: Count files in current directory
- `decomment`: Remove full-line comments and blank lines
- `mnt`: List mounted hard drives
- `..`, `...`, `....`, `.....`: Easy directory navigation
- `path`: Display formatted PATH
- `h`: Search command history
- `+x`, `-x`: Chmod shortcuts
- `ols`: Octal `ls -l`

## Functions

### venv_manager

A comprehensive virtual environment manager for Python projects.

Usage:
```bash
venv_manager {create|remove|activate|deactivate|status|howto} [venv_dir] [python_executable]
```

### ex (Extract and Compress)

A versatile function for extracting and compressing various types of archives.

Usage:
```bash
ex [OPTIONS] file1 [file2 ...]
```

Options:
- `-x`, `--extract`: Extract mode (default)
- `-c`, `--compress` format: Compress mode (specify format: tar.gz, tar.bz2, zip, 7z)
- `-v`, `--verbose`: Verbose mode
- `-t`, `--target` dir: Specify target directory
- `-d`, `--delete`: Delete original file(s) after operation
- `-e`, `--exclude` pattern: Exclude files/directories matching the pattern

### rcp (Remote Copy)

A function for copying files/directories locally or to/from remote systems, supporting both rsync and scp.

Usage:
```bash
rcp [OPTIONS] source destination
```

Options:
- `-z`, `--compress`: Compress the transfer
- `-m`, `--move`: Move files instead of copying
- `-u`, `--user` USERNAME: Specify username for remote connections
- `-p`, `--port` PORT: Specify SSH port
- `-i`, `--identity` FILE: Specify SSH identity file
- `-l`, `--limit` RATE: Set bandwidth limit (for rsync only)
- `-e`, `--exclude` FILE: Specify exclude file or pattern
- `-s`, `--use-scp`: Force using SCP instead of rsync
- `-v`, `--verbose`: Verbose output

### duu (Enhanced du)

An enhanced version of the `du` command with color-coded output and a bar chart.

Usage:
```bash
duu [directory]
```

### Other Utility Functions

- `mkd`: Create a new directory and enter it
- `swapf`: Swap two files or directories
- `evi`: Create and edit a new script file
- `topm`: Display top 20 memory-consuming processes
- `topc`: Display top 20 CPU-consuming processes

## Installation

1. Back up your existing `.bashrc` file:
   ```bash
   cp ~/.bashrc ~/.bashrc.backup
   ```

2. Copy this `.bashrc` file to your home directory:
   ```bash
   cp path/to/this/bashrc ~/.bashrc
   ```

3. Source the new `.bashrc` file:
   ```bash
   source ~/.bashrc
   ```

## Customization

Feel free to modify and extend this `.bashrc` file to suit your specific needs. You can add new aliases, functions, or adjust existing configurations.

## Contributing

If you have improvements or bug fixes, please open an issue or submit a pull request on GitHub.

## License

This `.bashrc` configuration is released under the MIT License. See the [LICENSE](LICENSE) file for details.
