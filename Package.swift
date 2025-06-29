// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "chponk",
  platforms: [
        .macOS(.v10_12)
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "chponk",
            dependencies: []),
    ]
)
