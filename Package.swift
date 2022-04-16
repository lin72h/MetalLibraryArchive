// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let packageDependencies: [Package.Dependency]
#if os(WASI)
packageDependencies = []
#else
packageDependencies = [.package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0")]
#endif

let metalLibraryArchiveTargetDependencies: [Target.Dependency]
#if os(WASI)
metalLibraryArchiveTargetDependencies = []
#else
metalLibraryArchiveTargetDependencies = [.product(name: "Crypto", package: "swift-crypto")]
#endif

let package = Package(
    name: "MetalLibraryArchive",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "MetalLibraryArchive",
            targets: ["MetalLibraryArchive"]),
    ],
    dependencies: packageDependencies,
    targets: [
        .executableTarget(name: "Explorer",
                          dependencies: [
                            "MetalLibraryArchive"
                          ]),
        .target(name: "MetalLibraryArchive",
                dependencies: metalLibraryArchiveTargetDependencies),
        .testTarget(
            name: "MetalLibraryArchiveTests",
            dependencies: [
                "MetalLibraryArchive"
            ]),
    ]
)
