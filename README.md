# Bookmark Commands Script

This script, `bookmark.sh`, allows you to save your most recent shell commands to a file, with the option to add a comment for context. It's designed to help you keep track of the commands you've run for specific tasks or projects, directly from your shell.

## Prerequisites

- Bash shell
- Access to the `history` command
- Permission to create and write to files in your home directory

## Setting Up the Alias

To ensure this script can access and manipulate the current shell's history, it must be run using the `source` command. You can simplify this process by setting up an alias:

1. Open your shell's configuration file (`~/.bashrc`, `~/.bash_profile`, `~/.zshrc`, etc.) in your preferred text editor.

2. Add the following alias command to the file:

```bash
alias bookmark='source $(pwd)/bookmark.sh'
```

3. Apply the changes by reloading your shell configuration:
```bash
source ~/.bashrc  # Or use the appropriate configuration file for your shell
```

Usage

After setting up the alias, you can start using bookmark to save your command history. Here are some examples of how to use it:

```bash
bookmark -c "This is a cool comment"
bookmark 5
bookmark -c "These are my last 5 commands" 5
```
