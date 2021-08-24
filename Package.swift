// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombineFoundation",
    products: [
        .library(
            name: "CombineFoundation",
            targets: ["CombineFoundation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "8.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CombineFoundation",
            dependencies: ["RxSwift",
                           .product(name: "RxCocoa", package: "RxSwift")],
            path: "CombineFoundation"),
        .testTarget(
            name: "CombineFoundationTests",
            dependencies: ["CombineFoundation",
                           "RxSwift",
                           "Nimble",
                           "Quick",
                           .product(name: "RxCocoa", package: "RxSwift")],
            path: "CombineFoundationTests"),
    ]
)
