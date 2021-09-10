// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iCombine",
    products: [
        .library(name: "iCombine", targets: ["iCombine"]),
        .library(name: "iCombineNetwork", targets: ["iCombineNetwork"]),
        .library(name: "iCombineUtility", targets: ["iCombineUtility"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "8.0.0"))
    ],
    targets: [
        .target(
            name: "iCombine",
            dependencies: ["RxSwift",
                           .product(name: "RxCocoa", package: "RxSwift")],
            path: "iCombine/iCombine"),
        .target(
            name: "iCombineNetwork",
            dependencies: ["iCombine"],
            path: "iCombineNetwork/iCombineNetwork"),
        .target(
            name: "iCombineUtility",
            dependencies: ["iCombine"],
            path: "iCombineUtility/iCombineUtility"),
        .testTarget(
            name: "iCombineTests",
            dependencies: ["iCombine",
                           "RxSwift",
                           "Nimble",
                           "Quick",
                           .product(name: "RxCocoa", package: "RxSwift")],
            path: "iCombine/iCombineTests"),
        .testTarget(
            name: "CombineTests",
            dependencies: ["iCombine",
                           "Nimble",
                           "Quick"],
            path: "iCombine/CombineTests"),
        .testTarget(
            name: "iCombineNetworkTests",
            dependencies: ["iCombineNetwork",
                           "Nimble",
                           "Quick"],
            path: "iCombineNetwork/iCombineNetworkTests"),
        .testTarget(
            name: "iCombineUtilityTests",
            dependencies: ["iCombineUtility",
                           "Nimble",
                           "Quick"],
            path: "iCombineUtility/iCombineUtilityTests"),
        .testTarget(
            name: "CombineUtilityTests",
            dependencies: ["iCombineUtility",
                           "Nimble",
                           "Quick"],
            path: "iCombineUtility/CombineUtilityTests")
    ]
)
