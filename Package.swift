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
        .package(name: "vapor", url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/handya/OhhAuth.git", from: "1.4.0")
    ],
    targets: [
        .target(name: "TwitterVapor", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "OhhAuth", package: "OhhAuth")
        ]),
        .testTarget(name: "TwitterVaporTests", dependencies: [
            .target(name: "TwitterVapor"),
            .product(name: "XCTVapor", package: "vapor")
        ]),
    ]
)
