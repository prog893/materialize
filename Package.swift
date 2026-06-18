// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "materialize",
    targets: [
        .executableTarget(
            name: "materialize",
            path: "Sources/materialize"
        )
    ]
)