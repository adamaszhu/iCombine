// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iCombine",
    products: [
        .library(
            name: "iCombine",
            targets: ["iCombine"]),
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
            name: "iCombine",
            dependencies: ["RxSwift",
                           .product(name: "RxCocoa", package: "RxSwift")],
            path: "iCombine"),
        .testTarget(
            name: "iCombineTests",
            dependencies: ["iCombine",
                           "RxSwift",
                           "Nimble",
                           "Quick",
                           .product(name: "RxCocoa", package: "RxSwift")],
            path: "iCombineTests")
    ]
)
