// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Api",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_12),
        .watchOS(.v2),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "Api",
            targets: [
                "Api"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            from: .init("5.4.3")
        ),
        .package(
            url: "https://github.com/mxcl/PromiseKit.git",
            from: .init("6.15.3")
        )
    ],
    targets: [
        .target(
            name: "Api",
            dependencies: [
                .product(name: "Alamofire"),
                .product(name: "PromiseKit")
            ]
        ),
        .testTarget(
            name: "ApiTests",
            dependencies: [
                "Api"
            ]
        )
    ]
)
