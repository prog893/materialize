# materialize

Force-download cloud-only files via NSFileCoordinator.

## Problem

macOS cloud storage providers (Google Drive, Dropbox, OneDrive) use **NSFileCoordinator** (part of Apple's Cloud Storage Kit) to stream files on demand.

Finder and most macOS apps handle this automatically — you can open a cloud-only file in TextEdit or VS Code without issues.

But CLI tools (cat, grep, etc.) and AI agents using bash/exec tools to read files will error:

## Solution

`materialize` uses NSFileCoordinator to force macOS to fully download a file from cloud storage before proceeding.

## Usage

```bash
materialize <path> [path ...]
```

Blocks until files are ready. Returns 0 on success, 1 on failure.

## Example

```bash
# Read a cloud-only file from Google Drive, Dropbox, or OneDrive
materialize "$FILE" && cat "$FILE"

# Process multiple files
materialize file1.txt file2.txt file3.txt
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