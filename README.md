# materialize

Force-download cloud-only files via NSFileCoordinator.

## Problem

macOS cloud storage providers (Google Drive, Dropbox, OneDrive) sometimes show files as "available" but haven't actually downloaded them yet. Reading these files causes "Resource deadlock avoided" errors or returns stale/empty content.

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
brew install prog893/tap/materialize
```

## Building from source

```bash
cd /path/to/materialize
swift build -c release
cp .build/release/materialize /usr/local/bin/
```

## Author

Tamirlan Torgayev (@torgayev)

## License

MIT