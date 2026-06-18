# materialize

Force-download cloud-only files via NSFileCoordinator.

## Problem

macOS Google Drive sometimes shows files as "available" but hasn't actually downloaded them yet. Reading these files causes "Resource deadlock avoided" errors or returns stale/empty content.

## Solution

`materialize` uses NSFileCoordinator to force macOS to fully download a file from cloud storage before proceeding.

## Usage

```bash
materialize <path> [path ...]
```

Blocks until files are ready. Returns 0 on success, 1 on failure.

## Example

```bash
# Read a Google Drive file that's cloud-only
materialize "$FILE" && cat "$FILE"

# Process multiple files
materialize file1.txt file2.txt file3.txt
```

## Installation

```bash
brew install torgayev/tap/materialize
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