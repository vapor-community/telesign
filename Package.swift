// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "telesign",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Telesign", targets: ["Telesign"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor-community/telesign-kit.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "Telesign", dependencies: [
            .product(name: "TelesignKit", package: "telesign-kit"),
            .product(name: "Vapor", package: "vapor"),
        ]),
    ]
)
