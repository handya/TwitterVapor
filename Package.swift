// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "TwitterVapor",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "TwitterVapor", targets: ["TwitterVapor"]),
    ],
    dependencies: [
        .package(name: "vapor", url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
    ],
    targets: [
        .target(name: "TwitterVapor", dependencies: [
            .product(name: "Vapor", package: "vapor"),
        ]),
        .testTarget(name: "TwitterVaporTests", dependencies: [
            .target(name: "TwitterVapor"),
            .product(name: "XCTVapor", package: "vapor"),
        ]),
    ]
)
