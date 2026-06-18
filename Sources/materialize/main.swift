import Foundation

guard CommandLine.arguments.count >= 2 else {
    fputs("Usage: materialize <path> [path ...]\n", stderr)
    fputs("Downloads cloud-only files via NSFileCoordinator.\n", stderr)
    fputs("Blocks until file is ready. Returns 0 on success, 1 on failure.\n", stderr)
    exit(1)
}

let paths = CommandLine.arguments.dropFirst()
var hadError = false

for path in paths {
    let url = URL(fileURLWithPath: path)
    let sem = DispatchSemaphore(value: 0)
    let coord = NSFileCoordinator(filePresenter: nil)
    var coordError: NSError?

    coord.coordinate(readingItemAt: url, options: .withoutChanges, error: &coordError) { newURL in
        // Just reading the first byte forces full materialization
        _ = try? Data(contentsOf: newURL)
        sem.signal()
    }

    sem.wait()

    if let e = coordError {
        fputs("materialize: \(path): \(e.localizedDescription)\n", stderr)
        hadError = true
    }
}

exit(hadError ? 1 : 0)
