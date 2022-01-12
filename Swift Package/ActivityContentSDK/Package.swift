// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ActivityContentSDK",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ActivityContentSDK",
            targets: ["ActivityContentSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/bitflying/SwiftKeccak.git", from: "0.1.0"),
        .package(url: "https://github.com/Flight-School/AnyCodable", from: "0.6.0"),
    ],
    targets: [
        .target(
            name: "ActivityContentSDK",
            dependencies: [
                .product(name: "SwiftKeccak", package: "SwiftKeccak"),
                .product(name: "AnyCodable", package: "AnyCodable"),
            ]),
        .testTarget(
            name: "ActivityContentSDKTests",
            dependencies: ["ActivityContentSDK"]),
    ]
)
