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
Example:

cpperm /path/to/source/file /path/to/destination/file
