// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppwriteTools",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AppwriteTools",
            targets: ["AppwriteTools"]),
    ],
    dependencies: [
        .package(url: "git@github.com:appwrite/sdk-for-apple.git", from: "5.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AppwriteTools",
            dependencies: [
                .product(name: "Appwrite", package: "sdk-for-apple")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AppwriteToolsTests",
            dependencies: ["AppwriteTools"]),
    ]
)
