// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "gdal-swift",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "gdal-swift",
            targets: ["gdal-swift"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "gdal",
            // This URL should be updated after GDAL recompile
            url: "https://github.com/syngenta/gdal-swift/releases/download/1.0.0/gdal.xcframework.zip",
            // After changing the URL, you should also update the 'checksum'.
            // Run 'swift package compute-checksum gdal.xcframework.zip' command to get the 'checksum'.
            checksum: "d786dcb6b38927859d98008a8ad51be5aace98d77335befee88bfd7697ca3b81"
        ),
        .target(
            name: "gdal-swift",
            dependencies: ["gdal"],
            path: "Sources",
            exclude: ["gdal"],
            cSettings: [.define("VALID_ARCHS", to: "arm64")],
            cxxSettings: [.define("VALID_ARCHS", to: "arm64")],
            linkerSettings: [
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
                .linkedLibrary("xml2"),
                .linkedLibrary("iconv")
            ]
        ),
        .testTarget(
            name: "UnitTests",
            dependencies: ["gdal-swift"],
            path: "Tests/Tests",
            resources: [.process("Files")],
            cxxSettings: [.define("VALID_ARCHS", to: "arm64")]
        )
    ],
    swiftLanguageVersions: [.v5],
    cxxLanguageStandard: .cxx14
)
