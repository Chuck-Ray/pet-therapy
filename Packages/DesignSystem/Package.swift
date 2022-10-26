// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.macOS(.v11), .iOS(.v15)],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"])
    ],
    dependencies: [
        .package(url: "https://github.com/curzel-it/schwifty", from: "1.0.4"),
        .package(url: "https://github.com/curzel-it/squanch", from: "1.0.7")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "Schwifty", package: "Schwifty"),
                .product(name: "Squanch", package: "Squanch")
            ]
        )
    ]
)
