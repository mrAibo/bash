# Shell Utility Functions

This repository contains useful shell functions designed to simplify certain tasks in your daily workflow. Each function is tailored to solve specific problems efficiently.

## Functions

### 1. `cpperm`

The `cpperm` function copies permissions, owner, and group information from a source file or directory to a destination file or directory.

#### Usage:

```bash
cpperm <source> <destination>

Parameters:
<source>: Path to the source file or directory from which permissions are to be copied.
<destination>: Path to the destination file or directory where the permissions will be applied.

#### Usage

```bash
cpperm /path/to/source/file /path/to/destination/file

This command will copy the permissions, owner, and group from /path/to/source/file to /path/to/destination/file.

### 2. swapfiles
The swapfiles function swaps two files by exchanging their names.

#### Usage:

swapfiles <file1> <file2>

Parameters:
<file1>: Path to the first file to be swapped.
<file2>: Path to the second file to be swapped.

swapfiles /path/to/file1 /path/to/file2

This command will swap file1 and file2 by renaming the files.

Installation
To use these functions, simply add them to your .bashrc or .bash_profile file. This will allow you to access the functions directly from your terminal.
