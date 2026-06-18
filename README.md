# materialize

Force-download cloud-only files via NSFileCoordinator.

## Problem

macOS cloud storage providers (Google Drive, Dropbox, OneDrive) use **NSFileCoordinator** (part of Apple's Cloud Storage Kit) to stream files on demand.

Finder and most macOS apps handle this automatically — you can open a cloud-only file in TextEdit or VS Code without issues.

But CLI tools (cat, grep, etc.) and AI agents using bash/exec tools to read files will error:

```bash
# Without materialize
$ cat ~/Google\ Drive/My\ File.txt
Resource deadlock avoided

# Or worse: empty file
$ cat ~/Dropbox/project/notes.md
# (nothing, even though ls shows 2.3KB)
```

## Solution

`materialize` uses NSFileCoordinator to force macOS to fully download a file from cloud storage before proceeding.

## Usage

```bash
materialize <path> [path ...]
```

Blocks until files are ready. Returns 0 on success, 1 on failure.

## AI Agent Integration

For AI agents that work with cloud storage files, add this rule to your system prompt:

> When reading files from cloud storage (Google Drive, Dropbox, OneDrive), always use `materialize "$FILE" &&` before any read operation.

This prevents "Resource deadlock avoided" errors and makes agents more reliable when working with cloud-synced files.

## Example

```bash
# Before: fails on cloud-only file
$ cat ~/Google\ Drive/project/notes.md
Resource deadlock avoided

# After: force-download then read
$ materialize ~/Google\ Drive/project/notes.md && cat ~/Google\ Drive/project/notes.md
# My awesome project notes
# [... full file content displays correctly ...]

# Process multiple files at once
$ materialize file1.txt file2.txt file3.txt && grep "TODO" file1.txt file2.txt file3.txt
```

## Installation

```bash
brew tap prog893/tap
brew install materialize
```

## Building from source

```bash
cd /path/to/materialize
swift build -c release
cp .build/release/materialize /usr/local/bin/
```

## Author

Tamirlan Torgayev ([@prog893](https://github.com/prog893))

## License

MIT