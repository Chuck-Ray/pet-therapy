// swift-tools-version: 5.7.1

import PackageDescription

let package = Package(
    name: "PetsSelection",
    platforms: [.macOS(.v11), .iOS(.v15)],
    products: [
        .library(
            name: "PetsSelection",
            targets: ["PetsSelection"]
        )
    ],
    dependencies: [
        .package(path: "../DesignSystem"),
        .package(path: "../Pets"),
        .package(path: "../Tracking"),
        .package(path: "../Yage"),
        .package(url: "https://github.com/curzel-it/schwifty", from: "1.0.13")
    ],
    targets: [
        .target(
            name: "PetsSelection",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Pets", package: "Pets"),
                .product(name: "Schwifty", package: "Schwifty"),
                .product(name: "Tracking", package: "Tracking"),
                .product(name: "Yage", package: "Yage")
            ]
        ),
        .testTarget(
            name: "PetsSelectionTests",
            dependencies: ["PetsSelection"]
        )
    ]
)
