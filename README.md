# Shell Scripting

A collection of Bash examples and small Linux administration scripts. The numbered scripts cover shell fundamentals and build up to loops, functions, arguments, file handling, and debugging. The `projects/` directory contains practical system-management examples.

## Requirements

- Bash
- A Linux environment for the system-administration examples
- Some scripts use standard utilities such as `ping`, `awk`, `df`, `free`, and `logger`; scripts in `projects/` may also use tools such as `apt`, `systemctl`, and `mail`

## Getting started

Clone the repository and run an example with Bash:

```bash
git clone <repository-url>
cd shell-scripting
bash 01_basic.sh
```

Most scripts are examples rather than polished command-line tools. Read a script before running it: some expect input files or arguments, interact with the network, or require elevated privileges. The infinite-loop examples run until interrupted with `Ctrl+C`.

## Examples

The numbered scripts are organized roughly by topic:

| Scripts | Topics |
| --- | --- |
| `01`–`07` | Basic output, comments, variables, constants, arrays, key-value arrays, and string operations |
| `08`–`14` | User input, arithmetic, conditionals, `case`, logical operators, and ternary-style expressions |
| `15`–`23` | `for`, `while`, and `until` loops, including examples using arrays and files |
| `24`–`29` | Functions, command-line arguments, `shift`, `break`, and `continue` |
| `30`–`37` | Connectivity and file checks, a dice example, root-user checks, redirection, script names, logging, and debugging |

## Projects

- `projects/archive_project.sh` — compresses files larger than 20 MB under a configured directory and moves them into an archive directory.
- `projects/create_server_user.sh` — creates a Linux user and sets an initial password; requires root privileges.
- `projects/fs_status.sh` and `projects/ram_status.sh` — basic disk-space and memory checks.

The project scripts may contain machine-specific placeholders and assumptions. Review and adapt scripts for your environment before use; run administrative scripts only when you understand their effects.
