// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ImageTransition",
    platforms: [.iOS("12.0")],
    products: [
        .library(
            name: "ImageTransition",
            targets: ["ImageTransition"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ImageTransition",
            dependencies: []),
        .testTarget(
            name: "ImageTransitionTests",
            dependencies: ["ImageTransition"])
    ]
)
