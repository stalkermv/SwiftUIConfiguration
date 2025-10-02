// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIConfiguration",
    platforms: [.iOS(.v18), .macOS(.v15), .tvOS(.v18), .watchOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftUIConfiguration",
            targets: ["SwiftUIConfiguration"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-configuration.git", from: "0.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftUIConfiguration",
            dependencies: [
                .product(name: "Configuration", package: "swift-configuration")
            ]
        ),
        .testTarget(
            name: "SwiftUIConfigurationTests",
            dependencies: ["SwiftUIConfiguration"]
        ),
    ]
)
