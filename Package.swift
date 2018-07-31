// swift-tools-version:4.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArgumentParser",
    products: [
        .library(name: "ArgumentParser", targets: ["ArgumentParser"]),
    ],
    targets: [
        .target(name: "ArgumentParser", dependencies: []),
        .testTarget(name: "ArgumentParserTests", dependencies: ["ArgumentParser"]),
    ]
)
